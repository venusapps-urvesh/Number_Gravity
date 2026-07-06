#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main() {
  final levels = <Map<String, dynamic>>[];
  var id = 1;

  for (var world = 1; world <= 8; world++) {
    final size = switch (world) {
      1 => 4,
      2 || 3 => 5,
      4 || 5 => 6,
      6 || 7 => 7,
      _ => 8,
    };

    for (var i = 0; i < 25; i++) {
      levels.add(_levelFor(world: world, id: id, size: size, index: i));
      id++;
    }
  }

  for (var world = 1; world <= 8; world++) {
    final worldLevels = levels.where((l) => l['world'] == world).toList();
    final file = File('assets/levels/world_${world.toString().padLeft(2, '0')}.json');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert({'levels': worldLevels}),
    );
    print('Wrote ${file.path} (${worldLevels.length} levels)');
  }
}

Map<String, dynamic> _levelFor({
  required int world,
  required int id,
  required int size,
  required int index,
}) {
  final tier = switch (world) {
    1 => 'beginner',
    2 || 3 => 'beginner',
    4 || 5 => 'intermediate',
    6 || 7 => 'advanced',
    _ => 'advanced',
  };

  final value = world == 2 ? -2 - (index % 3) : 2 + (index % 4);
  final goalRow = size - 1;
  final goalCol = size - 1;

  final tiles = <Map<String, dynamic>>[
    {
      'id': 't1',
      'type': 'number',
      'value': value,
      'row': 0,
      'col': 0,
      'isLocked': false,
    },
    {
      'id': 'g1',
      'type': 'goal',
      'value': 0,
      'row': goalRow,
      'col': goalCol,
      'isLocked': true,
    },
  ];

  if (world >= 3 && index.isEven) {
    tiles.add({
      'id': 'w1',
      'type': 'wall',
      'value': 0,
      'row': size ~/ 2,
      'col': size ~/ 2,
      'isLocked': true,
    });
  }

  return {
    'id': id,
    'world': world,
    'tier': tier,
    'rows': size,
    'cols': size,
    'objective': {
      'type': 'position',
      'tileId': 't1',
      'goalRow': goalRow,
      'goalCol': goalCol,
    },
    'tiles': tiles,
    'minimumMoves': 3 + (index % 5),
    'solutionMoves': ['R', 'D', 'R'],
  };
}
