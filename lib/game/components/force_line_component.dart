import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../models/move.dart';
import '../../models/simulation/force_vector.dart';
import 'board_component.dart';

class ForceLineComponent extends Component {
  ForceLineComponent({required this.boardComponent});

  final BoardComponent boardComponent;
  List<ForceVector> vectors = const [];

  void updateVectors(List<ForceVector> newVectors) {
    vectors = newVectors;
  }

  @override
  void render(Canvas canvas) {
    for (final vector in vectors) {
      final target = boardComponent.board.tileById(vector.targetTileId);
      if (target == null) {
        continue;
      }
      final center = boardComponent.cellCenter(target.row, target.col);
      final length = (vector.force.clamp(0.5, 5.0) * 8) + 12;
      final paint = Paint()
        ..color = (vector.isRepulsion ? AppColors.negative : AppColors.positive)
            .withValues(alpha: 0.7)
        ..strokeWidth = (vector.force.clamp(0.5, 5.0) * 1.5)
        ..style = PaintingStyle.stroke;

      final end = switch (vector.direction) {
        Direction.up => center + Vector2(0, -length),
        Direction.down => center + Vector2(0, length),
        Direction.left => center + Vector2(-length, 0),
        Direction.right => center + Vector2(length, 0),
      };

      canvas.drawLine(center.toOffset(), end.toOffset(), paint);
    }
  }
}
