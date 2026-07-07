import '../../core/constants/game_constants.dart';
import '../../models/level/level_model.dart';
import '../../models/objective/objective_model.dart';
import '../../models/simulation/simulation_result.dart';
import '../../models/simulation/tile_action.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';
import '../components/board_component.dart';
import 'tile_effects.dart';

/// Drives per-action Flame effects for each simulation cycle step.
class SimulationAnimator {
  SimulationAnimator({
    required this.boardComponent,
    required this.level,
    this.reduceMotion = false,
  });

  final BoardComponent boardComponent;
  final LevelModel level;
  final bool reduceMotion;

  double get _cycleDuration =>
      animationCycleStepMs / 1000;

  /// Animates [result] cycle-by-cycle, then snaps to [result.finalBoard].
  Future<void> animate(SimulationResult result) async {
    if (reduceMotion) {
      final last = result.steps.isNotEmpty
          ? result.steps.last.boardSnapshot
          : result.finalBoard;
      await boardComponent.updateBoard(last);
      return;
    }

    for (final step in result.steps) {
      if (step.actions.isEmpty) {
        continue;
      }
      await _animateStep(step.actions);
      await boardComponent.updateBoard(step.boardSnapshot);
    }

    await boardComponent.updateBoard(result.finalBoard);
    _maybeGlowGoal(result);
  }

  Future<void> _animateStep(List<TileAction> actions) async {
    final futures = <Future<void>>[];

    for (final action in actions) {
      final tile = boardComponent.tileComponentFor(action.tileId);
      if (tile == null) {
        continue;
      }

      switch (action.actionType) {
        case TileActionType.move:
        case TileActionType.portal:
          final target = boardComponent.cellTopLeft(action.toRow, action.toCol);
          futures.add(
            playMoveTo(tile, target, duration: _cycleDuration),
          );
        case TileActionType.collide:
        case TileActionType.merge:
        case TileActionType.split:
          playCollisionPulse(tile);
        case TileActionType.annihilate:
          futures.add(playFadeOut(tile, duration: _cycleDuration * 0.75));
        case TileActionType.modify:
        case TileActionType.invert:
          playCollisionPulse(tile);
        case TileActionType.toggle:
          break;
      }

      if (action.actionType == TileActionType.portal) {
        final relatedId = action.relatedTileId;
        if (relatedId != null) {
          final related = boardComponent.tileComponentFor(relatedId);
          if (related != null) {
            futures.add(playFadeIn(related, duration: _cycleDuration * 0.75));
          }
        }
      }
    }

    if (futures.isNotEmpty) {
      await Future.wait(futures);
    } else {
      await Future<void>.delayed(
        Duration(milliseconds: animationCycleStepMs),
      );
    }
  }

  void _maybeGlowGoal(SimulationResult result) {
    TileModel? goalTile;
    for (final tile in boardComponent.board.tiles) {
      if (tile.type == TileType.goal) {
        goalTile = tile;
        break;
      }
    }
    if (goalTile == null) {
      return;
    }

    final objectiveTileId = switch (level.objective) {
      PositionObjective(:final tileId) => tileId,
      _ => null,
    };
    if (objectiveTileId == null) {
      return;
    }

    final objective = result.finalBoard.tileById(objectiveTileId);
    if (objective == null) {
      return;
    }

    final onGoal = switch (level.objective) {
      PositionObjective(:final goalRow, :final goalCol) =>
        objective.row == goalRow && objective.col == goalCol,
      _ => false,
    };
    if (!onGoal) {
      return;
    }

    final goalComponent = boardComponent.tileComponentFor(goalTile.id);
    if (goalComponent != null) {
      playGoalGlow(goalComponent);
    }
  }
}
