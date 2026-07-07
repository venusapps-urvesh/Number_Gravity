import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:number_gravity/core/constants/game_constants.dart';
import 'package:number_gravity/levels/world_config.dart';
import 'package:number_gravity/storage/adapters/level_progress.dart';
import 'package:number_gravity/storage/adapters/level_progress_adapter.dart';
import 'package:number_gravity/storage/adapters/player_progress.dart';
import 'package:number_gravity/storage/adapters/player_progress_adapter.dart';
import 'package:number_gravity/storage/hive_boxes.dart';
import 'package:number_gravity/storage/repositories/hive_progress_repository.dart';

void main() {
  group('HiveProgressRepository', () {
    late Directory tempDir;
    late HiveProgressRepository repository;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('number_gravity_progress');
      Hive.init(tempDir.path);
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(LevelProgressAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(PlayerProgressAdapter());
      }
      final box = await Hive.openBox<PlayerProgress>(HiveBoxes.playerProgress);
      repository = HiveProgressRepository(box);
    });

    tearDown(() async {
      await Hive.close();
      await tempDir.delete(recursive: true);
    });

    test('level 2 is locked until level 1 is completed', () async {
      expect(await repository.isLevelUnlocked(1), isTrue);
      expect(await repository.isLevelUnlocked(2), isFalse);

      await repository.setLevelStars(levelId: 1, stars: 3, movesUsed: 2);

      expect(await repository.isLevelUnlocked(2), isTrue);
    });

    test('unlockWorld adds world to unlocked list', () async {
      final progress = await repository.getProgress();
      expect(progress.unlockedWorlds, [1]);

      await repository.unlockWorld(2);

      final updated = await repository.getProgress();
      expect(updated.unlockedWorlds, containsAll([1, 2]));
    });

    test('world 2 unlocks after completing last level of world 1', () async {
      final world1 = worldConfigs.first;
      for (var id = world1.startLevel; id <= world1.endLevel; id++) {
        await repository.setLevelStars(levelId: id, stars: 2, movesUsed: 4);
      }

      if (world1.id < totalWorlds) {
        await repository.unlockWorld(world1.id + 1);
      }

      final progress = await repository.getProgress();
      expect(progress.unlockedWorlds, contains(2));
      expect(
        progress.levelProgress[world1.endLevel]?.isCompleted,
        isTrue,
      );
    });

    test('setLevelStars keeps best star rating on replay', () async {
      await repository.setLevelStars(levelId: 1, stars: 1, movesUsed: 8);
      await repository.setLevelStars(levelId: 1, stars: 3, movesUsed: 3);

      expect(await repository.getLevelStars(1), 3);
    });

    test('isLevelUnlocked helper matches repository rule', () async {
      final progress = PlayerProgress(
        levelProgress: {
          1: LevelProgress(levelId: 1, stars: 3, isCompleted: true),
        },
      );

      expect(isLevelUnlocked(progress, 1), isTrue);
      expect(isLevelUnlocked(progress, 2), isTrue);
      expect(isLevelUnlocked(PlayerProgress(), 2), isFalse);
    });
  });
}
