import 'package:hive/hive.dart';

class AchievementRecord extends HiveObject {
  AchievementRecord({
    required this.id,
    this.unlockedAt,
  });

  String id;
  DateTime? unlockedAt;
}
