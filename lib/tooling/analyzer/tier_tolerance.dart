/// Difficulty tier ordering per production doc §6.
const List<String> difficultyTierOrder = [
  'beginner',
  'intermediate',
  'advanced',
  'expert',
];

int tierIndex(String tier) {
  return difficultyTierOrder.indexOf(tier.toLowerCase());
}

/// Returns true when [analyzed] is within [bands] of [expected] on the tier ladder.
bool tierWithinTolerance(
  String expected,
  String analyzed, {
  int bands = 1,
}) {
  final expectedIndex = tierIndex(expected);
  final analyzedIndex = tierIndex(analyzed);
  if (expectedIndex < 0 || analyzedIndex < 0) {
    return true;
  }
  return (analyzedIndex - expectedIndex).abs() <= bands;
}

String expectedTierForWorld(int worldId) {
  return switch (worldId) {
    1 || 2 || 3 => 'beginner',
    4 || 5 => 'intermediate',
    6 || 7 || 8 => 'advanced',
    _ => 'beginner',
  };
}
