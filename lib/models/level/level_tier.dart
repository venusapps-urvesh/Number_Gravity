import 'package:json_annotation/json_annotation.dart';

enum LevelTier {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('expert')
  expert,
}

extension LevelTierX on LevelTier {
  String get label => name;
}
