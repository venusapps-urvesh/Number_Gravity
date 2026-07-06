import 'package:json_annotation/json_annotation.dart';

/// Tile types defined in production doc Section 3.
enum TileType {
  @JsonValue('number')
  number,
  @JsonValue('wall')
  wall,
  @JsonValue('portal')
  portal,
  @JsonValue('multiplier')
  multiplier,
  @JsonValue('divider')
  divider,
  @JsonValue('inverter')
  inverter,
  @JsonValue('freeze')
  freeze,
  @JsonValue('switchTile')
  switchTile,
  @JsonValue('door')
  door,
  @JsonValue('goal')
  goal,
}

extension TileTypeX on TileType {
  bool get isMovableByDefault {
    switch (this) {
      case TileType.number:
        return true;
      case TileType.freeze:
        return false;
      case TileType.wall:
      case TileType.portal:
      case TileType.multiplier:
      case TileType.divider:
      case TileType.inverter:
      case TileType.switchTile:
      case TileType.door:
      case TileType.goal:
        return false;
    }
  }

  bool get blocksMovement {
    switch (this) {
      case TileType.wall:
        return true;
      case TileType.door:
        return true;
      case TileType.number:
      case TileType.portal:
      case TileType.multiplier:
      case TileType.divider:
      case TileType.inverter:
      case TileType.freeze:
      case TileType.switchTile:
      case TileType.goal:
        return false;
    }
  }

  bool get emitsGravity {
    switch (this) {
      case TileType.number:
      case TileType.freeze:
        return true;
      case TileType.wall:
      case TileType.portal:
      case TileType.multiplier:
      case TileType.divider:
      case TileType.inverter:
      case TileType.switchTile:
      case TileType.door:
      case TileType.goal:
        return false;
    }
  }
}
