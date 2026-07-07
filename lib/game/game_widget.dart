import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/router/navigation.dart';
import '../app/router/routes.dart';
import '../core/constants/game_constants.dart';
import '../levels/world_config.dart';
import '../core/utils/responsive.dart';
import '../l10n/app_localizations.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/move.dart';
import '../models/replay/move_record.dart';
import '../providers/providers.dart';
import '../simulation/board_applier.dart';
import '../widgets/game/game_action_bar.dart';
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

class _NumberGravityGameWidgetState
    extends ConsumerState<NumberGravityGameWidget> {
  NumberGravityGame? _game;
  int _movesUsed = 0;
  int _hintsRemaining = 2;
  bool _handlingVictory = false;
  bool _handlingStuck = false;
  bool _levelStartRecorded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_levelStartRecorded && mounted) {
        _levelStartRecorded = true;
        ref.read(statisticsRepositoryProvider).recordLevelStart();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NumberGravityGameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level.id != widget.level.id) {
      _game = null;
      _movesUsed = 0;
      _hintsRemaining = 2;
      _handlingVictory = false;
      _handlingStuck = false;
      _levelStartRecorded = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_levelStartRecorded && mounted) {
          _levelStartRecorded = true;
          ref.read(statisticsRepositoryProvider).recordLevelStart();
        }
      });
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
      onLevelStuck: _handleLevelStuck,
    );

    final board = GameWidget(game: _game!);

    final hud = GameHud(
      levelId: widget.level.id,
      movesUsed: _movesUsed,
      optimalMoves: widget.level.minimumMoves,
      coinAmount: progress?.coins ?? 0,
      onPause: _showPauseMenu,
    );

    final actionBar = GameActionBar(
      canUndo: _game!.canUndo,
      canHint: _hintsRemaining > 0 && widget.level.solutionMoves.isNotEmpty,
      hintCount: _hintsRemaining,
      onUndo: () {
        _game?.undo();
        setState(() => _movesUsed = _game?.movesUsed ?? 0);
        ref.read(statisticsRepositoryProvider).recordUndo();
      },
      onHint: () => _useHint(l10n),
    );

    final boardView = GestureDetector(onPanEnd: _handleSwipe, child: board);

    final forceSlot = ForceIndicator(vectors: const []);

    if (isTablet) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            hud,
            forceSlot,
            Expanded(child: Center(child: boardView)),
            actionBar,
          ],
        ),
      );
    }

    return Column(
      children: [
        hud,
        forceSlot,
        Expanded(child: boardView),
        actionBar,
      ],
    );
  }

  void _handleSwipe(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond;
    if (velocity.distance < 120) {
      return;
    }

    final absDx = velocity.dx.abs();
    final absDy = velocity.dy.abs();
    final direction = absDx >= absDy
        ? (velocity.dx > 0 ? Direction.right : Direction.left)
        : (velocity.dy > 0 ? Direction.down : Direction.up);

    _game?.commitDirection(direction).then((_) {
      if (mounted) {
        setState(() => _movesUsed = _game?.movesUsed ?? _movesUsed);
        ref.read(statisticsRepositoryProvider).recordMove();
      }
    });
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
        _exitGameplay();
      },
    ).whenComplete(() => _game?.setPaused(false));
  }

  void _useHint(AppLocalizations l10n) {
    if (_hintsRemaining <= 0) {
      return;
    }

    final used = _game?.showHint() ?? false;
    if (!used) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.hint)));
      return;
    }

    setState(() => _hintsRemaining--);
    ref.read(statisticsRepositoryProvider).recordHintUsed();
  }

  void _exitGameplay() {
    if (widget.level.world == 0) {
      context.go(AppRoutes.daily);
      return;
    }
    ngExitPlayToLevels(context, widget.level.world);
  }

  void _handleLevelStuck(BoardModel board, int movesUsed) {
    if (_handlingStuck || !mounted) {
      return;
    }
    _handlingStuck = true;

    showGameStuckSheet(
      context,
      onUndo: () {
        _game?.undo();
        _game?.clearStuck();
        setState(() {
          _movesUsed = _game?.movesUsed ?? 0;
          _handlingStuck = false;
        });
        ref.read(statisticsRepositoryProvider).recordUndo();
      },
      onRestart: () {
        _game?.restart();
        _game?.clearStuck();
        setState(() {
          _movesUsed = 0;
          _handlingStuck = false;
        });
      },
      onExit: () {
        _game?.clearStuck();
        _handlingStuck = false;
        _exitGameplay();
      },
    );
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

    final progressBefore =
        await ref.read(progressRepositoryProvider).getProgress();
    final isFirstClear =
        !(progressBefore.levelProgress[widget.level.id]?.isCompleted ?? false);
    final coinsEarned = isFirstClear
        ? switch (stars) {
            3 => coinsPerStar3,
            2 => coinsPerStar2,
            _ => coinsPerStar1,
          }
        : 0;

    await ref
        .read(progressRepositoryProvider)
        .setLevelStars(
          levelId: widget.level.id,
          stars: stars,
          movesUsed: movesUsed,
        );

    final world = worldForLevel(widget.level.id);
    if (world != null &&
        widget.level.id == world.endLevel &&
        world.id < totalWorlds) {
      await ref.read(progressRepositoryProvider).unlockWorld(world.id + 1);
    }

    await ref.read(statisticsRepositoryProvider).recordLevelComplete();

    final progress = await ref.read(progressRepositoryProvider).getProgress();
    if (coinsEarned > 0) {
      progress.coins += coinsEarned;
      progress.gameplayEarnedCoins += coinsEarned;
    }
    if (widget.level.world == 0) {
      progress.dailyStreak += 1;
    }
    if (coinsEarned > 0 || widget.level.world == 0) {
      await ref.read(progressRepositoryProvider).saveProgress(progress);
    }
    ref.invalidate(playerProgressProvider);

    final solutionCode = ref
        .read(replayServiceProvider)
        .encodeMoves(moveRecords);
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
