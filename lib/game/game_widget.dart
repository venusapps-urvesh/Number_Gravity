import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/router/routes.dart';
import '../core/utils/responsive.dart';
import '../l10n/app_localizations.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../providers/providers.dart';
import '../simulation/board_applier.dart';
import '../widgets/common/ng_direction_pad.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final engine = ref.watch(gravityEngineProvider);
    final progress = ref.watch(playerProgressProvider).value;
    final isTablet = ResponsiveBreakpoints.isTablet(context);

    _game ??= NumberGravityGame(
      bridge: SimulationBridge(engine: engine, applier: BoardApplier()),
      initialBoard: widget.level.board,
      colorBlindMode: colorBlind,
      onMoveCommitted: (_, board) {
        setState(() => _movesUsed++);
        widget.onMoveCommitted?.call(board);
      },
    );

    final board = GameWidget(game: _game!);

    final hud = GameHud(
      levelId: widget.level.id,
      movesUsed: _movesUsed,
      optimalMoves: widget.level.minimumMoves,
      coinAmount: progress?.coins ?? 0,
      hintCount: 2,
      onUndo: () {},
      onRedo: () {},
      onHint: () {},
      onRestart: () {
        setState(() {
          _movesUsed = 0;
          _game?.setBoard(widget.level.board);
        });
      },
      onSettings: () => context.push(AppRoutes.settings),
    );

    final directionPad = NGDirectionPad(
      label: l10n.swipeToMove,
      onDirection: (direction) => _game?.commitDirection(direction),
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
}
