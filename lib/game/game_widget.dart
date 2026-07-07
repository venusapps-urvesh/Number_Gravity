import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/game_constants.dart';
import '../core/utils/responsive.dart';
import '../l10n/app_localizations.dart';
import '../levels/world_config.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/move.dart';
import '../providers/game_session_provider.dart';
import '../providers/providers.dart';
import '../services/economy/coin_service.dart';
import '../services/economy/helper_pricing.dart';
import '../simulation/board_applier.dart';
import '../widgets/game/game_action_bar.dart';
import '../widgets/game/game_pause_sheet.dart';
import '../widgets/game/game_hud.dart';
import '../widgets/game/helper_cost_sheet.dart';
import '../widgets/game/level_intro_sheet.dart';
import '../widgets/game/objective_banner.dart';
import '../widgets/game/star_progress_chip.dart';
import 'bridges/simulation_bridge.dart';
import 'game_flow_controller.dart';
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
  bool _handlingVictory = false;
  bool _handlingStuck = false;
  bool _levelStartRecorded = false;
  bool _introShown = false;

  @override
  void initState() {
    super.initState();
    _initGame();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recordLevelStart();
      _maybeShowWorldIntro();
    });
  }

  @override
  void didUpdateWidget(covariant NumberGravityGameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level.id != widget.level.id) {
      _handlingVictory = false;
      _handlingStuck = false;
      _levelStartRecorded = false;
      _introShown = false;
      ref.read(gameSessionProvider(widget.level).notifier).onRestart();
      _initGame();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _recordLevelStart();
        _maybeShowWorldIntro();
      });
    }
  }

  void _initGame() {
    final engine = ref.read(gravityEngineProvider);
    final colorBlind = ref.read(colorBlindModeProvider).value ?? false;
    final reduceMotion = ref.read(reduceMotionProvider).value ?? false;
    final flow = GameFlowController(ref);

    _game = NumberGravityGame(
      bridge: SimulationBridge(engine: engine, applier: BoardApplier()),
      level: widget.level,
      colorBlindMode: colorBlind,
      reduceMotion: reduceMotion,
      onMoveCommitted: (_, board) {
        ref.read(gameSessionProvider(widget.level).notifier).onMoveCommitted();
        widget.onMoveCommitted?.call(board);
      },
      onSessionSync: ({
        required movesUsed,
        required canUndo,
        required canRedo,
        required isAnimating,
        required isWon,
        required isStuck,
      }) {
        ref.read(gameSessionProvider(widget.level).notifier).syncFromGame(
              movesUsed: movesUsed,
              canUndo: canUndo,
              canRedo: canRedo,
              isAnimating: isAnimating,
              isWon: isWon,
              isStuck: isStuck,
            );
      },
      onTileSelected: ({required tileId, required legalDirections}) {
        ref.read(gameSessionProvider(widget.level).notifier).onTileSelected(
              tileId: tileId,
              forces: const [],
              directions: legalDirections,
            );
      },
      onPreview: ({required direction, required ghostBoard}) {
        ref.read(gameSessionProvider(widget.level).notifier).onPreview(
              direction: direction,
              ghostBoard: ghostBoard,
            );
      },
      onSelectionCleared: () {
        ref.read(gameSessionProvider(widget.level).notifier).clearSelection();
      },
      onLevelWon: (board, movesUsed, records) => _handleLevelWon(
        flow,
        board,
        movesUsed,
        records,
      ),
      onLevelStuck: (board, movesUsed) {
        final flow = GameFlowController(ref);
        _handleLevelStuck(flow, AppLocalizations.of(context));
      },
    );
  }

  void _recordLevelStart() {
    if (!_levelStartRecorded && mounted) {
      _levelStartRecorded = true;
      ref.read(statisticsRepositoryProvider).recordLevelStart();
    }
  }

  void _maybeShowWorldIntro() {
    if (_introShown || !mounted) {
      return;
    }
    final world = worldForLevel(widget.level.id);
    if (world == null || widget.level.id != world.startLevel) {
      return;
    }
    _introShown = true;
    showLevelIntroSheet(context, world: world);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveBreakpoints.isTablet(context);
    final game = _game;
    if (game == null) {
      return const SizedBox.shrink();
    }

    final column = Column(
      children: [
        _GameHudSection(level: widget.level, onPause: _showPauseMenu),
        ObjectiveBanner(level: widget.level),
        Expanded(
          child: _FlameBoardHost(
            game: game,
            onPanUpdate: _handlePanUpdate,
            onPanEnd: _handlePanEnd,
          ),
        ),
        _GameActionBarSection(
          level: widget.level,
          onUndo: _handleUndo,
          onRedo: _handleRedo,
          onHint: _handleHint,
          onRestart: () {
            _game?.restart();
            ref.read(gameSessionProvider(widget.level).notifier).onRestart();
          },
        ),
      ],
    );

    if (isTablet) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: column,
      );
    }
    return column;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    final delta = details.delta;
    if (delta.distance < 4) {
      return;
    }
    final direction = delta.dx.abs() >= delta.dy.abs()
        ? (delta.dx > 0 ? Direction.right : Direction.left)
        : (delta.dy > 0 ? Direction.down : Direction.up);
    _game?.previewDirection(direction);
  }

  void _handlePanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond;
    _game?.clearPreview();
    ref.read(gameSessionProvider(widget.level).notifier).clearPreview();

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
        ref.read(statisticsRepositoryProvider).recordMove();
      }
    });
  }

  Future<void> _handleUndo() async {
    final l10n = AppLocalizations.of(context);
    final flow = GameFlowController(ref);
    final session = ref.read(gameSessionProvider(widget.level));
    final undoCost = undoCostForLevel(session.undoCountThisLevel);
    final balance = ref.read(playerProgressProvider).value?.coins ?? 0;

    if (undoCost > 0) {
      final confirmed = await showHelperCostSheet(
        context,
        title: l10n.undo,
        body: l10n.undoCostCoins(undoCost),
        cost: undoCost,
        balance: balance,
      );
      if (confirmed != true || !mounted) {
        return;
      }
      final spent = await flow.trySpendForHelper(
        cost: undoCost,
        sink: CoinSink.undo,
      );
      if (!spent) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.notEnoughCoins)),
          );
        }
        return;
      }
    }

    _game?.undo();
    ref.read(gameSessionProvider(widget.level).notifier).onUndo();
    ref.read(statisticsRepositoryProvider).recordUndo();
  }

  Future<void> _handleRedo() async {
    final l10n = AppLocalizations.of(context);
    final flow = GameFlowController(ref);
    final balance = ref.read(playerProgressProvider).value?.coins ?? 0;
    const cost = coinCostRedo;

    final confirmed = await showHelperCostSheet(
      context,
      title: l10n.redo,
      body: l10n.undoCostCoins(cost),
      cost: cost,
      balance: balance,
    );
    if (confirmed != true || !mounted) {
      return;
    }
    final spent = await flow.trySpendForHelper(cost: cost, sink: CoinSink.redo);
    if (!spent) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.notEnoughCoins)),
        );
      }
      return;
    }

    _game?.redo();
    ref.read(gameSessionProvider(widget.level).notifier).onRedo();
  }

  Future<void> _handleHint() async {
    final l10n = AppLocalizations.of(context);
    final flow = GameFlowController(ref);
    final balance = ref.read(playerProgressProvider).value?.coins ?? 0;

    final tier = await showHintTierSheet(context);
    if (tier == null || !mounted) {
      return;
    }

    final cost = hintCostForTier(tier);
    final confirmed = await showHelperCostSheet(
      context,
      title: l10n.hint,
      body: switch (tier) {
        1 => l10n.hintTier1Title,
        2 => l10n.hintTier2Title,
        _ => l10n.hintTier3Title,
      },
      cost: cost,
      balance: balance,
    );
    if (confirmed != true || !mounted) {
      return;
    }

    final spent = await flow.trySpendForHelper(
      cost: cost,
      sink: sinkForHintTier(tier),
    );
    if (!spent) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.notEnoughCoins)),
        );
      }
      return;
    }

    final used = _game?.showHint(tier: tier) ?? false;
    if (!used) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.hintUnavailable)),
        );
      }
      return;
    }

    ref.read(gameSessionProvider(widget.level).notifier).onHintUsed(tier);
    ref.read(statisticsRepositoryProvider).recordHintUsed();
  }

  void _showPauseMenu() {
    final flow = GameFlowController(ref);
    _game?.setPaused(true);
    showGamePauseSheet(
      context,
      colorBlindEnabled: ref.read(colorBlindModeProvider).value ?? false,
      reduceMotionEnabled: ref.read(reduceMotionProvider).value ?? false,
      onColorBlindChanged: (v) =>
          ref.read(colorBlindModeProvider.notifier).setEnabled(v),
      onReduceMotionChanged: (v) =>
          ref.read(reduceMotionProvider.notifier).setEnabled(v),
      onHowToPlay: () => _game?.setPaused(false),
      onResume: () => _game?.setPaused(false),
      onRestart: () {
        _game?.setPaused(false);
        _game?.restart();
        ref.read(gameSessionProvider(widget.level).notifier).onRestart();
      },
      onLevels: () => flow.exitGameplay(context, widget.level),
    ).whenComplete(() => _game?.setPaused(false));
  }

  Future<void> _handleLevelWon(
    GameFlowController flow,
    BoardModel board,
    int movesUsed,
    List records,
  ) async {
    if (_handlingVictory || !mounted) {
      return;
    }
    _handlingVictory = true;
    await flow.handleLevelWon(
      context: context,
      level: widget.level,
      movesUsed: movesUsed,
      moveRecords: records.cast(),
    );
  }

  void _handleLevelStuck(GameFlowController flow, AppLocalizations l10n) {
    if (_handlingStuck || !mounted) {
      return;
    }
    _handlingStuck = true;

    showGameStuckSheet(
      context,
      onHint: () {
        Navigator.of(context).pop();
        _handlingStuck = false;
        _game?.clearStuck();
        _handleHint();
      },
      onUndo: () {
        _game?.undo();
        _game?.clearStuck();
        ref.read(gameSessionProvider(widget.level).notifier).onUndo();
        setState(() => _handlingStuck = false);
        ref.read(statisticsRepositoryProvider).recordUndo();
      },
      onRestart: () {
        _game?.restart();
        _game?.clearStuck();
        ref.read(gameSessionProvider(widget.level).notifier).onRestart();
        setState(() => _handlingStuck = false);
      },
      onExit: () {
        _game?.clearStuck();
        _handlingStuck = false;
        flow.exitGameplay(context, widget.level);
      },
    );
  }
}

/// Keeps [GameWidget] stable — must not rebuild when session HUD state changes.
class _FlameBoardHost extends StatefulWidget {
  const _FlameBoardHost({
    required this.game,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  final NumberGravityGame game;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;

  @override
  State<_FlameBoardHost> createState() => _FlameBoardHostState();
}

class _FlameBoardHostState extends State<_FlameBoardHost> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: widget.onPanUpdate,
        onPanEnd: widget.onPanEnd,
        child: GameWidget(
          game: widget.game,
          backgroundBuilder: (context) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _GameHudSection extends ConsumerWidget {
  const _GameHudSection({
    required this.level,
    required this.onPause,
  });

  final LevelModel level;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameSessionProvider(level));
    final balance = ref.watch(playerProgressProvider).value?.coins ?? 0;

    return GameHud(
      levelId: level.id,
      movesUsed: session.movesUsed,
      optimalMoves: level.minimumMoves,
      coinAmount: balance,
      onPause: onPause,
      starChip: StarProgressChip(
        movesUsed: session.movesUsed,
        minimumMoves: level.minimumMoves,
      ),
    );
  }
}

class _GameActionBarSection extends ConsumerWidget {
  const _GameActionBarSection({
    required this.level,
    required this.onUndo,
    required this.onRedo,
    required this.onHint,
    required this.onRestart,
  });

  final LevelModel level;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final Future<void> Function() onHint;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(gameSessionProvider(level));
    final undoCost = undoCostForLevel(session.undoCountThisLevel);

    return GameActionBar(
      canUndo: session.canUndo && !session.isAnimating,
      canRedo: session.canRedo && !session.isAnimating,
      canHint: !session.isAnimating &&
          level.solutionMoves.isNotEmpty &&
          session.movesUsed < level.solutionMoves.length,
      undoCostLabel:
          undoCost == 0 ? l10n.undoCostFree : l10n.undoCostCoins(undoCost),
      redoCostLabel: l10n.undoCostCoins(coinCostRedo),
      onUndo: onUndo,
      onRedo: onRedo,
      onHint: () => onHint(),
      onRestart: onRestart,
    );
  }
}
