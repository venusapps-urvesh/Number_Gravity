import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/router/navigation.dart';
import '../app/router/routes.dart';
import '../core/constants/game_constants.dart';
import '../core/utils/responsive.dart';
import '../l10n/app_localizations.dart';
import '../levels/world_config.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/replay/move_record.dart';
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
import '../widgets/game/win_overlay.dart';
import 'bridges/simulation_bridge.dart';
import 'game_flow_controller.dart';
import 'gameplay_options.dart';
import 'layout/board_layout.dart';
import 'number_gravity_game.dart';

class NumberGravityGameWidget extends ConsumerStatefulWidget {
  const NumberGravityGameWidget({
    required this.level,
    this.options = GameplayOptions.campaign,
    this.onMoveCommitted,
    super.key,
  });

  final LevelModel level;
  final GameplayOptions options;
  final void Function(BoardModel board)? onMoveCommitted;

  @override
  ConsumerState<NumberGravityGameWidget> createState() =>
      _NumberGravityGameWidgetState();
}

class _PendingWin {
  const _PendingWin({
    required this.board,
    required this.movesUsed,
    required this.records,
  });

  final BoardModel board;
  final int movesUsed;
  final List<MoveRecord> records;
}

class _NumberGravityGameWidgetState
    extends ConsumerState<NumberGravityGameWidget> {
  NumberGravityGame? _game;
  bool _handlingVictory = false;
  bool _handlingStuck = false;
  bool _levelStartRecorded = false;
  bool _introShown = false;
  _PendingWin? _pendingWin;

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
      _pendingWin = null;
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

    _game = NumberGravityGame(
      bridge: SimulationBridge(engine: engine, applier: BoardApplier()),
      level: widget.level,
      colorBlindMode: colorBlind,
      reduceMotion: reduceMotion,
      onMoveCommitted: (_, board) {
        ref.read(gameSessionProvider(widget.level).notifier).onMoveCommitted();
        widget.onMoveCommitted?.call(board);
      },
      onSessionSync:
          ({
            required movesUsed,
            required canUndo,
            required canRedo,
            required isAnimating,
            required isWon,
            required isStuck,
          }) {
            ref
                .read(gameSessionProvider(widget.level).notifier)
                .syncFromGame(
                  movesUsed: movesUsed,
                  canUndo: canUndo,
                  canRedo: canRedo,
                  isAnimating: isAnimating,
                  isWon: isWon,
                  isStuck: isStuck,
                );
          },
      onTileSelected:
          ({required tileId, required legalDirections, required forces}) {
            ref
                .read(gameSessionProvider(widget.level).notifier)
                .onTileSelected(
                  tileId: tileId,
                  forces: forces,
                  directions: legalDirections,
                );
          },
      onPreview: ({required direction, required ghostBoard}) {
        ref
            .read(gameSessionProvider(widget.level).notifier)
            .onPreview(direction: direction, ghostBoard: ghostBoard);
      },
      onSelectionCleared: () {
        ref.read(gameSessionProvider(widget.level).notifier).clearSelection();
      },
      onLevelWon: (board, movesUsed, records) {
        if (widget.options.showWinOverlay) {
          setState(() {
            _pendingWin = _PendingWin(
              board: board,
              movesUsed: movesUsed,
              records: records,
            );
          });
          if (widget.options.autoNavigateOnWin) {
            _completeWinNavigation(records, movesUsed);
          }
        } else {
          _handleLevelWon(GameFlowController(ref), board, movesUsed, records);
        }
      },
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
        _GameHudSection(
          level: widget.level,
          options: widget.options,
          onPause: _showPauseMenu,
        ),
        ObjectiveBanner(level: widget.level),
        Expanded(child: _FlameBoardHost(game: game)),
        _GameActionBarSection(
          level: widget.level,
          options: widget.options,
          onUndo: _handleUndo,
          onHint: _handleHint,
        ),
      ],
    );

    if (isTablet) {
      final content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: column,
      );
      return Stack(
        children: [
          content,
          if (_pendingWin != null && widget.options.showWinOverlay)
            Positioned.fill(
              child: WinOverlay(
                movesUsed: _pendingWin!.movesUsed,
                minimumMoves: widget.level.minimumMoves,
                reduceMotion: ref.watch(reduceMotionProvider).value ?? false,
                onLevels: _onWinLevels,
                onNextLevel: () => _onWinNextLevel(_pendingWin!),
                onReplay: _onWinReplay,
              ),
            ),
        ],
      );
    }
    return Stack(
      children: [
        column,
        if (_pendingWin != null && widget.options.showWinOverlay)
          Positioned.fill(
            child: WinOverlay(
              movesUsed: _pendingWin!.movesUsed,
              minimumMoves: widget.level.minimumMoves,
              reduceMotion: ref.watch(reduceMotionProvider).value ?? false,
              onLevels: _onWinLevels,
              onNextLevel: () => _onWinNextLevel(_pendingWin!),
              onReplay: _onWinReplay,
            ),
          ),
      ],
    );
  }

  Future<void> _onWinNextLevel(_PendingWin pending) async {
    if (_handlingVictory || !mounted) {
      return;
    }
    _handlingVictory = true;
    await _completeWinNavigation(pending.records, pending.movesUsed);
    if (!mounted) {
      return;
    }
  }

  Future<void> _completeWinNavigation(
    List<MoveRecord> records,
    int movesUsed,
  ) async {
    final flow = GameFlowController(ref);
    await flow.persistLevelWin(
      level: widget.level,
      movesUsed: movesUsed,
      moveRecords: records,
    );
    if (!mounted) {
      return;
    }
    final nextId = widget.level.id + 1;
    if (nextId <= totalLaunchLevels) {
      ngPushToPlay(context, nextId);
      return;
    }
    flow.navigateToVictory(context, widget.level);
  }

  void _onWinReplay() {
    setState(() => _pendingWin = null);
    _handlingVictory = false;
    _game?.restart();
    ref.read(gameSessionProvider(widget.level).notifier).onRestart();
  }

  void _onWinLevels() {
    setState(() => _pendingWin = null);
    _handlingVictory = false;
    GameFlowController(ref).exitGameplay(context, widget.level);
  }

  Future<bool> _handleUndo() async {
    final l10n = AppLocalizations.of(context);
    final flow = GameFlowController(ref);
    final session = ref.read(gameSessionProvider(widget.level));

    if (widget.options.economyEnabled) {
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
          return false;
        }
        final spent = await flow.trySpendForHelper(
          cost: undoCost,
          sink: CoinSink.undo,
        );
        if (!spent) {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.notEnoughCoins)));
          }
          return false;
        }
      }
    }

    _game?.undo();
    ref.read(gameSessionProvider(widget.level).notifier).onUndo();
    ref.read(statisticsRepositoryProvider).recordUndo();
    return true;
  }

  Future<void> _handleHint() async {
    final l10n = AppLocalizations.of(context);
    final flow = GameFlowController(ref);
    const tier = 3;

    if (widget.options.economyEnabled) {
      final balance = ref.read(playerProgressProvider).value?.coins ?? 0;
      final cost = hintCostForTier(tier);
      if (balance < cost) {
        if (mounted) {
          context.push(AppRoutes.shop);
        }
        return;
      }

      final spent = await flow.trySpendForHelper(
        cost: cost,
        sink: sinkForHintTier(tier),
      );
      if (!spent) {
        if (mounted) {
          context.push(AppRoutes.shop);
        }
        return;
      }
    }

    final used = await (_game?.showHint(tier: tier) ?? Future.value(false));
    if (!used) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.hintUnavailable)));
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
        setState(() => _pendingWin = null);
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
      onUndo: () async {
        final undone = await _handleUndo();
        if (!mounted) {
          return;
        }
        if (undone) {
          _game?.clearStuck();
        }
        setState(() => _handlingStuck = false);
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
  const _FlameBoardHost({required this.game});

  final NumberGravityGame game;

  @override
  State<_FlameBoardHost> createState() => _FlameBoardHostState();
}

class _FlameBoardHostState extends State<_FlameBoardHost> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        if (width <= 0 || height <= 0) {
          return const SizedBox.shrink();
        }

        final layout = BoardLayout.fit(
          rows: widget.game.level.board.rows,
          cols: widget.game.level.board.cols,
          maxWidth: width,
          maxHeight: height,
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }
          widget.game.applyLayout(viewportWidth: width, viewportHeight: height);
        });

        return Center(
          child: SizedBox(
            width: layout.boardWidth,
            height: layout.boardHeight,
            child: GameWidget(
              game: widget.game,
              loadingBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

class _GameHudSection extends ConsumerWidget {
  const _GameHudSection({
    required this.level,
    required this.options,
    required this.onPause,
  });

  final LevelModel level;
  final GameplayOptions options;
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
      showCoins: options.economyEnabled,
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
    required this.options,
    required this.onUndo,
    required this.onHint,
  });

  final LevelModel level;
  final GameplayOptions options;
  final Future<bool> Function() onUndo;
  final Future<void> Function() onHint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(gameSessionProvider(level));
    final freeRemaining = freeUndosRemaining(session.undoCountThisLevel);
    final undoSubtitle = options.economyEnabled && freeRemaining == 0
        ? l10n.undoCostCoins(coinCostUndoAfterFree)
        : null;
    final undoBadgeCount = options.economyEnabled && freeRemaining > 0
        ? freeRemaining
        : null;

    return GameActionBar(
      canUndo: session.canUndo && !session.isAnimating,
      canHint: !session.isAnimating && !session.isWon,
      undoSubtitle: undoSubtitle,
      undoBadgeCount: undoBadgeCount,
      onUndo: () {
        onUndo();
      },
      onHint: () => onHint(),
    );
  }
}
