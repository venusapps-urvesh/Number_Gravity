import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/simulation/force_calculator.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/simulation/tie_breaker.dart';

void main() {
  group('TieBreaker', () {
    const breaker = TieBreaker();

    test('equal opposing same kind does not move', () {
      final forces = DirectionalForceMap(up: 2, down: 2, left: 0, right: 0);
      expect(breaker.resolveMovement(forces), isNull);
    });

    test('attraction vs repulsion tie resolves to repulsion', () {
      final forces = DirectionalForceMap(up: 3, down: -3, left: 0, right: 0);
      expect(breaker.resolveMovement(forces), Direction.down);
    });

    test('equal axis pull prefers vertical', () {
      final forces = DirectionalForceMap(up: 0, down: 2, left: 0, right: 2);
      expect(breaker.resolveMovement(forces), Direction.down);
    });
  });
}
