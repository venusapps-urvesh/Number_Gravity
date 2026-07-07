import '../../models/board_model.dart';
import '../../models/move.dart';
import '../../models/tile_type.dart';

extension BoardModelExtensions on BoardModel {
  bool canAcceptPlayerMove(Move move) {
    final tile = tileById(move.tileId);
    if (tile == null || !tile.isMovable) {
      return false;
    }

    final targetRow = tile.row + move.direction.rowDelta;
    final targetCol = tile.col + move.direction.colDelta;

    if (!isInBounds(targetRow, targetCol)) {
      return false;
    }

    final destination = tileAt(targetRow, targetCol);
    if (destination == null) {
      return true;
    }

    if (destination.isMovable) {
      return false;
    }

    return !destination.type.blocksMovement;
  }

  List<Move> legalMovesForTile(String tileId) {
    final tile = tileById(tileId);
    if (tile == null || !tile.isMovable) {
      return const [];
    }

    final moves = <Move>[];
    for (final direction in Direction.values) {
      final move = Move(tileId: tileId, direction: direction);
      if (canAcceptPlayerMove(move)) {
        moves.add(move);
      }
    }
    return moves;
  }
}
