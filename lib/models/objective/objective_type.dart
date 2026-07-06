import 'package:json_annotation/json_annotation.dart';

enum ObjectiveType {
  @JsonValue('position')
  position,
  @JsonValue('sequence')
  sequence,
  @JsonValue('sum')
  sum,
  @JsonValue('balance')
  balance,
  @JsonValue('collection')
  collection,
  @JsonValue('chain')
  chain,
}
