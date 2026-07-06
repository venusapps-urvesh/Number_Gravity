import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/move.dart';
import '../providers/providers.dart';
import '../simulation/board_applier.dart';
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

  @override
  Widget build(BuildContext context) {
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final engine = ref.watch(gravityEngineProvider);

    _game ??= NumberGravityGame(
      bridge: SimulationBridge(engine: engine, applier: BoardApplier()),
      initialBoard: widget.level.board,
      colorBlindMode: colorBlind,
      onMoveCommitted: (_, board) => widget.onMoveCommitted?.call(board),
    );

    return Column(
      children: [
        Expanded(
          child: GameWidget(game: _game!),
        ),
        _DirectionPad(
          onDirection: (direction) => _game?.commitDirection(direction),
        ),
      ],
    );
  }
}

class _DirectionPad extends StatelessWidget {
  const _DirectionPad({required this.onDirection});

  final ValueChanged<Direction> onDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          IconButton(
            onPressed: () => onDirection(Direction.up),
            icon: const Icon(Icons.keyboard_arrow_up_rounded),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => onDirection(Direction.left),
                icon: const Icon(Icons.keyboard_arrow_left_rounded),
              ),
              const SizedBox(width: 48),
              IconButton(
                onPressed: () => onDirection(Direction.right),
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
              ),
            ],
          ),
          IconButton(
            onPressed: () => onDirection(Direction.down),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ],
      ),
    );
  }
}
