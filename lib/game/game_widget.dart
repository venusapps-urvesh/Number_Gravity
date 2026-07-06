import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/router/navigation.dart';
import '../app/router/routes.dart';
import '../core/constants/game_constants.dart';
import '../core/utils/responsive.dart';
import '../l10n/app_localizations.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/replay/move_record.dart';
import '../providers/game_session_provider.dart';
import '../providers/providers.dart';
import '../simulation/board_applier.dart';
import '../widgets/common/ng_direction_pad.dart';
import '../widgets/game/game_pause_sheet.dart';
import '../widgets/game/force_indicator.dart';
import '../widgets/game/game_hud.dart';
import 'bridges/simulation_bridge.dart';
import 'number_gravity_game.dart';

class NumberGravityGameWidget extends ConsumerStatefulWidget {
  const NumberGravityGameWidget({
    required this.level,
    this.onMoveCommitted,
    super.key,
  });

  final LevelModel level;
  final void Function(BoardModel board)? onMoveCommitted;

  @override
  ConsumerState<NumberGravityGameWidget> createState() =>
      _NumberGravityGameWidgetState();
}

class _NumberGravityGameWidgetState extends ConsumerState<NumberGravityGameWidget> {
  NumberGravityGame? _game;
  int _movesUsed = 0;
  int _hintsRemaining = 2;
  bool _handlingVictory = false;

  @override
  void didUpdateWidget(covariant NumberGravityGameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level.id != widget.level.id) {
      _game = null;
      _movesUsed = 0;
      _hintsRemaining = 2;
      _handlingVictory = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final engine = ref.watch(gravityEngineProvider);
    final progress = ref.watch(playerProgressProvider).value;
    final isTablet = ResponsiveBreakpoints.isTablet(context);

    _game ??= NumberGravityGame(
      bridge: SimulationBridge(engine: engine, applier: BoardApplier()),
      level: widget.level,
      colorBlindMode: colorBlind,
      onMoveCommitted: (_, board) {
        setState(() => _movesUsed = _game?.movesUsed ?? _movesUsed);
        widget.onMoveCommitted?.call(board);
      },
      onLevelWon: _handleLevelWon,
    );

    final board = GameWidget(game: _game!);

    final hud = GameHud(
      levelId: widget.level.id,
      movesUsed: _movesUsed,
      optimalMoves: widget.level.minimumMoves,
      coinAmount: progress?.coins ?? 0,
      hintCount: _hintsRemaining,
      canUndo: _game!.canUndo,
      canHint: _hintsRemaining > 0 && widget.level.solutionMoves.isNotEmpty,
      onPause: _showPauseMenu,
      onUndo: () {
        _game?.undo();
        setState(() => _movesUsed = _game?.movesUsed ?? 0);
        ref.read(statisticsRepositoryProvider).recordUndo();
      },
      onHint: () => _useHint(l10n),
    );

    final directionPad = NGDirectionPad(
      label: l10n.swipeToMove,
      onDirection: (direction) async {
        await _game?.commitDirection(direction);
        if (mounted) {
          setState(() => _movesUsed = _game?.movesUsed ?? _movesUsed);
        }
      },
    );

    final forceSlot = ForceIndicator(vectors: const []);

    if (isTablet) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  hud,
                  forceSlot,
                  Expanded(child: Center(child: board)),
                ],
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [directionPad],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        hud,
        forceSlot,
        Expanded(child: board),
        directionPad,
      ],
    );
  }

  void _showPauseMenu() {
    _game?.setPaused(true);
    showGamePauseSheet(
      context,
      onResume: () => _game?.setPaused(false),
      onRestart: () {
        _game?.setPaused(false);
        _game?.restart();
        setState(() => _movesUsed = 0);
      },
      onLevels: () {
        ngExitPlayToLevels(context, widget.level.world);
      },
    ).whenComplete(() => _game?.setPaused(false));
  }

  void _useHint(AppLocalizations l10n) {
    if (_hintsRemaining <= 0) {
      return;
    }

    final used = _game?.showHint() ?? false;
    if (!used) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.hint)),
      );
      return;
    }

    setState(() => _hintsRemaining--);
    ref.read(statisticsRepositoryProvider).recordHintUsed();
  }

  Future<void> _handleLevelWon(
    BoardModel board,
    int movesUsed,
    List<MoveRecord> moveRecords,
  ) async {
    if (_handlingVictory || !mounted) {
      return;
    }
    _handlingVictory = true;

    final stars = starsForMoves(
      movesUsed: movesUsed,
      minimumMoves: widget.level.minimumMoves,
    );
    final coinsEarned = switch (stars) {
      3 => coinsPerStar3,
      2 => coinsPerStar2,
      _ => coinsPerStar1,
    };

    await ref.read(progressRepositoryProvider).setLevelStars(
          levelId: widget.level.id,
          stars: stars,
          movesUsed: movesUsed,
        );
    await ref.read(statisticsRepositoryProvider).recordLevelComplete();

    final progress = await ref.read(progressRepositoryProvider).getProgress();
    progress.coins += coinsEarned;
    progress.gameplayEarnedCoins += coinsEarned;
    await ref.read(progressRepositoryProvider).saveProgress(progress);
    ref.invalidate(playerProgressProvider);

    final solutionCode = ref.read(replayServiceProvider).encodeMoves(moveRecords);
    if (!mounted) {
      return;
    }

    context.go(
      '${AppRoutes.victory}/${widget.level.id}'
      '?stars=$stars'
      '&moves=$movesUsed'
      '&optimal=${widget.level.minimumMoves}'
      '&coins=$coinsEarned'
      '&balance=${progress.coins - coinsEarned}'
      '&solution=${Uri.encodeComponent(solutionCode)}',
    );
  }
}
