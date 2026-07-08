#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:number_gravity/levels/level_loader.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/tooling/analyzer/difficulty_analyzer.dart';
import 'package:number_gravity/tooling/analyzer/tier_tolerance.dart';

Future<void> main(List<String> args) async {
  final loader = LevelLoader();
  final analyzer = DifficultyAnalyzer();
  var mismatches = 0;

  for (var world = 1; world <= 8; world++) {
    final file = File(
      'assets/levels/world_${world.toString().padLeft(2, '0')}.json',
    );
    final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final levels = decoded['levels'] as List<dynamic>;

    for (final entry in levels) {
      final level = loader.parseLevel(entry as Map<String, dynamic>);
      final score = analyzer.analyze(level);
      final expected = expectedTierForWorld(level.world);
      final ok = tierWithinTolerance(expected, score.tier);

      if (!ok) {
        mismatches++;
        print(
          'Level ${level.id}: expected~$expected, analyzed=${score.tier} '
          '(score=${score.weightedTotal.toStringAsFixed(1)})',
        );
      }
    }
  }

  print('Tier mismatches: $mismatches');
  if (mismatches > 0) {
    exit(1);
  }
}
