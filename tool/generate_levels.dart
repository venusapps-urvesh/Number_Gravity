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
    final file =
        File('assets/levels/world_${world.toString().padLeft(2, '0')}.json');
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

  if (world >= 5) {
    _addWorld5PlusTiles(tiles, world: world, size: size, index: index);
  }

  final objective = world == 8 && index >= 20
      ? {
          'type': 'chain',
          'subObjectiveIds': ['t1'],
        }
      : {
          'type': 'position',
          'tileId': 't1',
          'goalRow': goalRow,
          'goalCol': goalCol,
        };

  return {
    'id': id,
    'world': world,
    'tier': tier,
    'rows': size,
    'cols': size,
    'objective': objective,
    'tiles': tiles,
    'minimumMoves': 3 + (index % 5),
    'solutionMoves': ['R', 'D', 'R'],
  };
}

void _addWorld5PlusTiles(
  List<Map<String, dynamic>> tiles, {
  required int world,
  required int size,
  required int index,
}) {
  if (world == 5) {
    tiles.addAll([
      {
        'id': 'p1',
        'type': 'portal',
        'value': 0,
        'row': 1,
        'col': 1,
        'isLocked': true,
        'portalPairId': 'p2',
      },
      {
        'id': 'p2',
        'type': 'portal',
        'value': 0,
        'row': size - 2,
        'col': size - 2,
        'isLocked': true,
        'portalPairId': 'p1',
      },
    ]);
    return;
  }

  if (world == 6) {
    if (index % 3 == 0) {
      tiles.add({
        'id': 'm1',
        'type': 'multiplier',
        'value': 0,
        'row': size ~/ 2,
        'col': 1,
        'isLocked': true,
        'modifierFactor': 2,
      });
    } else if (index % 3 == 1) {
      tiles.add({
        'id': 'd1',
        'type': 'divider',
        'value': 0,
        'row': size ~/ 2,
        'col': 1,
        'isLocked': true,
        'modifierFactor': 2,
      });
    } else {
      tiles.add({
        'id': 'i1',
        'type': 'inverter',
        'value': 0,
        'row': size ~/ 2,
        'col': 1,
        'isLocked': true,
      });
    }
    return;
  }

  if (world == 7) {
    if (index.isEven) {
      tiles.addAll([
        {
          'id': 's1',
          'type': 'switchTile',
          'value': 0,
          'row': 1,
          'col': size - 2,
          'isLocked': true,
          'switchId': 'sw1',
        },
        {
          'id': 'dr1',
          'type': 'door',
          'value': 0,
          'row': size ~/ 2,
          'col': size ~/ 2,
          'isLocked': true,
          'doorId': 'sw1',
          'isDoorOpen': false,
        },
      ]);
    } else {
      tiles.add({
        'id': 'f1',
        'type': 'freeze',
        'value': 3,
        'row': size ~/ 2,
        'col': 1,
        'isLocked': true,
      });
    }
    return;
  }

  // World 8 — mixed mechanics
  if (index % 4 == 0) {
    tiles.addAll([
      {
        'id': 'p1',
        'type': 'portal',
        'value': 0,
        'row': 1,
        'col': 1,
        'isLocked': true,
        'portalPairId': 'p2',
      },
      {
        'id': 'p2',
        'type': 'portal',
        'value': 0,
        'row': size - 2,
        'col': 2,
        'isLocked': true,
        'portalPairId': 'p1',
      },
    ]);
  } else if (index % 4 == 1) {
    tiles.add({
      'id': 'm1',
      'type': 'multiplier',
      'value': 0,
      'row': 2,
      'col': 2,
      'isLocked': true,
      'modifierFactor': 2,
    });
  } else if (index % 4 == 2) {
    tiles.add({
      'id': 's1',
      'type': 'switchTile',
      'value': 0,
      'row': 1,
      'col': size - 2,
      'isLocked': true,
      'switchId': 'sw1',
    });
  }
}
