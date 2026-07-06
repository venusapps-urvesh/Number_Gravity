#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final levelsDir = Directory('assets/levels');
  var valid = 0;
  var invalid = 0;

  for (final file in levelsDir.listSync().whereType<File>()) {
    if (!file.path.endsWith('.json')) {
      continue;
    }
    final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final levels = decoded['levels'] as List<dynamic>;
    for (final level in levels) {
      final map = level as Map<String, dynamic>;
      final ok = _validate(map);
      if (ok) {
        valid++;
      } else {
        invalid++;
        print('Invalid level ${map['id']} in ${file.path}');
      }
    }
  }

  print('Validated $valid levels, $invalid invalid');
  if (invalid > 0) {
    exit(1);
  }
}

bool _validate(Map<String, dynamic> level) {
  final required = ['id', 'world', 'tier', 'rows', 'cols', 'objective', 'tiles'];
  for (final key in required) {
    if (!level.containsKey(key)) {
      return false;
    }
  }
  final rows = level['rows'] as int;
  final cols = level['cols'] as int;
  return rows > 0 && cols > 0 && rows <= 10 && cols <= 10;
}
