import '../../core/constants/game_constants.dart';
import '../../models/board_model.dart';
import '../../models/simulation/tile_action.dart';
import '../../models/tile_model.dart';

/// Resolves tile collisions per Section 2.4.
class CollisionResolver {
  const CollisionResolver();

  CollisionResult resolve({
    required TileModel moving,
    required TileModel? occupant,
  }) {
    if (occupant == null) {
      return CollisionResult.moveOnly(moving);
    }

    if (!occupant.isMovable) {
      return CollisionResult.blocked();
    }

    if (moving.allowsMerge && occupant.allowsMerge &&
        _sameSign(moving.value, occupant.value)) {
      final merged = _clampValue(moving.value + occupant.value);
      return CollisionResult.merged(
        survivor: moving.copyWith(value: merged),
        removedId: occupant.id,
        mergedValue: merged,
      );
    }

    if (_sameSign(moving.value, occupant.value)) {
      if (moving.value.abs() == occupant.value.abs()) {
        return CollisionResult.stopped();
      }
      if (moving.value.abs() > occupant.value.abs()) {
        return CollisionResult.replaced(
          survivor: moving,
          removedId: occupant.id,
        );
      }
      return CollisionResult.blocked();
    }

    // Opposite signs.
    if (moving.value.abs() == occupant.value.abs()) {
      return CollisionResult.annihilated(moving.id, occupant.id);
    }

    if (moving.value.abs() > occupant.value.abs()) {
      final reduced = _clampValue(
        moving.value.sign * (moving.value.abs() - occupant.value.abs()),
      );
      return CollisionResult.replaced(
        survivor: moving.copyWith(value: reduced),
        removedId: occupant.id,
        resultingValue: reduced,
      );
    }

    final reduced = _clampValue(
      occupant.value.sign * (occupant.value.abs() - moving.value.abs()),
    );
    return CollisionResult.survivorOccupant(
      survivor: occupant.copyWith(value: reduced),
      removedId: moving.id,
      resultingValue: reduced,
    );
  }

  bool _sameSign(int a, int b) {
    return (a >= 0 && b >= 0) || (a <= 0 && b <= 0);
  }

  int _clampValue(int value) {
    if (value > maxTileValue) {
      return maxTileValue;
    }
    if (value < -maxTileValue) {
      return -maxTileValue;
    }
    if (value == 0) {
      return 0;
    }
    if (value.abs() < minTileMagnitude) {
      return value.sign * minTileMagnitude;
    }
    return value;
  }
}

class CollisionResult {
  const CollisionResult._({
    required this.kind,
    this.survivor,
    this.removedId,
    this.removedSecondId,
    this.resultingValue,
  });

  factory CollisionResult.moveOnly(TileModel survivor) {
    return CollisionResult._(kind: _kindMoveOnly, survivor: survivor);
  }

  factory CollisionResult.blocked() {
    return const CollisionResult._(kind: _kindBlocked);
  }

  factory CollisionResult.stopped() {
    return const CollisionResult._(kind: _kindStopped);
  }

  factory CollisionResult.replaced({
    required TileModel survivor,
    required String removedId,
    int? resultingValue,
  }) {
    return CollisionResult._(
      kind: _kindReplaced,
      survivor: survivor,
      removedId: removedId,
      resultingValue: resultingValue,
    );
  }

  factory CollisionResult.merged({
    required TileModel survivor,
    required String removedId,
    required int mergedValue,
  }) {
    return CollisionResult._(
      kind: _kindMerged,
      survivor: survivor,
      removedId: removedId,
      resultingValue: mergedValue,
    );
  }

  factory CollisionResult.annihilated(String firstId, String secondId) {
    return CollisionResult._(
      kind: _kindAnnihilated,
      removedId: firstId,
      removedSecondId: secondId,
    );
  }

  factory CollisionResult.survivorOccupant({
    required TileModel survivor,
    required String removedId,
    int? resultingValue,
  }) {
    return CollisionResult._(
      kind: _kindSurvivorOccupant,
      survivor: survivor,
      removedId: removedId,
      resultingValue: resultingValue,
    );
  }

  static const _kindMoveOnly = 'moveOnly';
  static const _kindBlocked = 'blocked';
  static const _kindStopped = 'stopped';
  static const _kindReplaced = 'replaced';
  static const _kindMerged = 'merged';
  static const _kindAnnihilated = 'annihilated';
  static const _kindSurvivorOccupant = 'survivorOccupant';

  final String kind;
  final TileModel? survivor;
  final String? removedId;
  final String? removedSecondId;
  final int? resultingValue;

  bool get isMoveOnly => kind == _kindMoveOnly;
  bool get isBlocked => kind == _kindBlocked;
  bool get isStopped => kind == _kindStopped;
  bool get isAnnihilated => kind == _kindAnnihilated;
}

extension CollisionResultActions on CollisionResult {
  List<TileAction> toActions({
    required TileModel moving,
    required int toRow,
    required int toCol,
  }) {
  return switch (kind) {
      CollisionResult._kindMoveOnly => [
          TileAction(
            tileId: moving.id,
            actionType: TileActionType.move,
            fromRow: moving.row,
            fromCol: moving.col,
            toRow: toRow,
            toCol: toCol,
          ),
        ],
      CollisionResult._kindMerged => [
          TileAction(
            tileId: moving.id,
            actionType: TileActionType.merge,
            fromRow: moving.row,
            fromCol: moving.col,
            toRow: toRow,
            toCol: toCol,
            resultingValue: resultingValue,
            relatedTileId: removedId,
          ),
        ],
      CollisionResult._kindReplaced => [
          TileAction(
            tileId: moving.id,
            actionType: TileActionType.collide,
            fromRow: moving.row,
            fromCol: moving.col,
            toRow: toRow,
            toCol: toCol,
            resultingValue: resultingValue,
            relatedTileId: removedId,
          ),
        ],
      CollisionResult._kindAnnihilated => [
          TileAction(
            tileId: moving.id,
            actionType: TileActionType.annihilate,
            fromRow: moving.row,
            fromCol: moving.col,
            toRow: toRow,
            toCol: toCol,
            relatedTileId: removedSecondId,
          ),
        ],
      CollisionResult._kindSurvivorOccupant => [
          TileAction(
            tileId: removedId!,
            actionType: TileActionType.annihilate,
            fromRow: moving.row,
            fromCol: moving.col,
            toRow: toRow,
            toCol: toCol,
            relatedTileId: survivor!.id,
          ),
        ],
      _ => const [],
    };
  }
}
