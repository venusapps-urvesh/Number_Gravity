import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:number_gravity/storage/adapters/settings_data.dart';
import 'package:number_gravity/storage/adapters/settings_data_adapter.dart';
import 'package:number_gravity/storage/hive_boxes.dart';
import 'package:number_gravity/storage/repositories/hive_settings_repository.dart';

void main() {
  group('HiveSettingsRepository', () {
    late Directory tempDir;
    late HiveSettingsRepository repository;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('number_gravity_test');
      Hive.init(tempDir.path);
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(SettingsDataAdapter());
      }
      final box = await Hive.openBox<SettingsData>(HiveBoxes.settings);
      repository = HiveSettingsRepository(box);
    });

    tearDown(() async {
      await Hive.close();
      await tempDir.delete(recursive: true);
    });

    test('persists theme mode', () async {
      await repository.setThemeMode(ThemeMode.dark);
      expect(await repository.getThemeMode(), ThemeMode.dark);

      await repository.setThemeMode(ThemeMode.light);
      expect(await repository.getThemeMode(), ThemeMode.light);
    });

    test('persists accessibility settings', () async {
      await repository.setColorBlindMode(true);
      await repository.setReduceMotion(true);

      expect(await repository.getColorBlindMode(), isTrue);
      expect(await repository.getReduceMotion(), isTrue);
    });
  });
}
