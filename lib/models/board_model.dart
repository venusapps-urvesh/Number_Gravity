import 'package:freezed_annotation/freezed_annotation.dart';

import 'tile_model.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
abstract class BoardModel with _$BoardModel {
  const BoardModel._();

  const factory BoardModel({
    required int rows,
    required int cols,
    @Default([]) List<TileModel> tiles,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  TileModel? tileAt(int row, int col) {
    TileModel? background;
    for (final tile in tiles) {
      if (tile.row == row && tile.col == col) {
        if (tile.isMovable) {
          return tile;
        }
        background = tile;
      }
    }
    return background;
  }

  /// Non-movable tile at a cell (portal, modifier, switch, wall, goal).
  TileModel? backgroundTileAt(int row, int col) {
    for (final tile in tiles) {
      if (tile.row == row && tile.col == col && !tile.isMovable) {
        return tile;
      }
    }
    return null;
  }

  /// All tiles stacked at a cell (movable + background).
  List<TileModel> tilesAt(int row, int col) {
    final result = <TileModel>[];
    for (final tile in tiles) {
      if (tile.row == row && tile.col == col) {
        result.add(tile);
      }
    }
    return result;
  }

  TileModel? tileById(String id) {
    for (final tile in tiles) {
      if (tile.id == id) {
        return tile;
      }
    }
    return null;
  }

  bool isInBounds(int row, int col) {
    return row >= 0 && col >= 0 && row < rows && col < cols;
  }

  bool isCellEmpty(int row, int col) => tileAt(row, col) == null;

  int get occupiedCells => tiles.length;

  BoardModel withTile(TileModel tile) {
    final updated = tiles
        .where((existing) => existing.id != tile.id)
        .toList(growable: true)
      ..add(tile);
    return copyWith(tiles: updated);
  }

  BoardModel withTiles(List<TileModel> newTiles) => copyWith(tiles: newTiles);

  BoardModel withoutTile(String id) {
    return copyWith(
      tiles: tiles.where((tile) => tile.id != id).toList(growable: false),
    );
  }

  BoardModel copyWithTileAt({
    required String tileId,
    required int row,
    required int col,
  }) {
    final tile = tileById(tileId);
    if (tile == null) {
      return this;
    }
    return withTile(tile.movedTo(row: row, col: col));
  }

  String toFlatHash() {
    final buffer = StringBuffer('$rows:$cols');
    final sorted = [...tiles]..sort((a, b) {
        final rowCompare = a.row.compareTo(b.row);
        if (rowCompare != 0) {
          return rowCompare;
        }
        return a.col.compareTo(b.col);
      });
    for (final tile in sorted) {
      buffer
        ..write('|')
        ..write(tile.id)
        ..write(':')
        ..write(tile.type.name)
        ..write(':')
        ..write(tile.value)
        ..write(':')
        ..write(tile.row)
        ..write(':')
        ..write(tile.col)
        ..write(':')
        ..write(tile.isLocked ? 1 : 0);
    }
    return buffer.toString();
  }
}
