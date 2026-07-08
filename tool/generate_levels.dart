#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:number_gravity/core/constants/game_constants.dart';
import 'package:number_gravity/tooling/generator/level_generator.dart';

Future<void> main(List<String> args) async {
  final worldsArg = _parseWorldsArg(args);
  final generator = LevelGenerator();
  final failures = <int>[];

  for (final world in worldsArg) {
    final levels = <Map<String, dynamic>>[];
    final startId = (world - 1) * levelsPerWorld + 1;

    for (var index = 0; index < levelsPerWorld; index++) {
      final levelId = startId + index;
      final generated = generator.generate(
        levelId: levelId,
        worldId: world,
        indexInWorld: index,
        maxAttempts: 2000,
      );

      if (generated == null) {
        failures.add(levelId);
        print('FAILED to generate level $levelId');
        continue;
      }

      levels.add(generated.levelJson);

      final solutionFile = File(
        'assets/levels/solutions/level_${levelId.toString().padLeft(3, '0')}.json',
      );
      solutionFile.parent.createSync(recursive: true);
      solutionFile.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(generated.solutionJson),
      );
    }

    if (levels.length == levelsPerWorld) {
      final worldFile = File(
        'assets/levels/world_${world.toString().padLeft(2, '0')}.json',
      );
      worldFile.parent.createSync(recursive: true);
      worldFile.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert({'levels': levels}),
      );
      print('Wrote ${worldFile.path} (${levels.length} levels)');
    }
  }

  if (failures.isNotEmpty) {
    print('Generation failures: $failures');
    exit(1);
  }
}

List<int> _parseWorldsArg(List<String> args) {
  if (args.isEmpty) {
    return List.generate(totalWorlds, (i) => i + 1);
  }

  final worlds = <int>[];
  for (final arg in args) {
    if (arg.startsWith('--world=')) {
      worlds.add(int.parse(arg.split('=').last));
    } else if (arg == '--world1') {
      worlds.add(1);
    }
  }
  return worlds.isEmpty ? [1] : worlds;
}
