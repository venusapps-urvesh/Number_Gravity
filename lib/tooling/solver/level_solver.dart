import 'dart:collection';

import '../../core/constants/game_constants.dart';
import '../../core/extensions/board_extensions.dart';
import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/objective/objective_model.dart';
import '../../simulation/board_applier.dart';
import '../../simulation/default_gravity_engine.dart';
import '../../simulation/gravity_engine.dart';
import '../../simulation/objective_checker.dart';

class SolverResult {
  const SolverResult({
    required this.solved,
    required this.moves,
    required this.minimumMoves,
    this.hitDepthCap = false,
    this.hitCycleCap = false,
    this.exploredStates = 0,
  });

  final bool solved;
  final List<Move> moves;
  final int minimumMoves;
  final bool hitDepthCap;
  final bool hitCycleCap;
  final int exploredStates;
}

/// Finds a shortest solution for [level] using BFS or A* over board states.
class LevelSolver {
  LevelSolver({
    GravityEngine? engine,
    BoardApplier? applier,
    ObjectiveChecker? objectiveChecker,
  })  : _engine = engine ?? DefaultGravityEngine(),
        _applier = applier ?? BoardApplier(),
        _objectiveChecker = objectiveChecker ?? const ObjectiveChecker();

  final GravityEngine _engine;
  final BoardApplier _applier;
  final ObjectiveChecker _objectiveChecker;

  SolverResult solve(LevelModel level, {int? maxDepth, int maxStates = 50000}) {
    final depthCap = maxDepth ?? solverDepthCapForTier(level.tier.name);
    final useAStar = level.board.rows * level.board.cols > 36;

    if (_objectiveChecker.isSolved(level, level.board)) {
      return const SolverResult(solved: true, moves: [], minimumMoves: 0);
    }

    if (useAStar) {
      return _solveAStar(level, depthCap, maxStates);
    }
    return _solveBfs(level, depthCap, maxStates);
  }

  SolverResult _solveBfs(LevelModel level, int depthCap, int maxStates) {
    final visited = <String>{};
    var explored = 0;
    var hitCycleCap = false;

    final queue = Queue<_SearchNode>()
      ..add(_SearchNode(board: level.board, moves: const []));

    while (queue.isNotEmpty) {
      if (explored >= maxStates) {
        return SolverResult(
          solved: false,
          moves: const [],
          minimumMoves: 0,
          hitDepthCap: true,
          hitCycleCap: hitCycleCap,
          exploredStates: explored,
        );
      }
      final node = queue.removeFirst();
      explored++;

      final hash = node.board.toFlatHash();
      if (visited.contains(hash)) {
        continue;
      }
      visited.add(hash);

      if (node.moves.length >= depthCap) {
        continue;
      }

      for (final tile in node.board.tiles.where((t) => t.isMovable)) {
        for (final move in _engine.legalMoves(node.board, tile.id)) {
          final (nextBoard, cycleCap) = _applyMove(node.board, move);
          if (cycleCap) {
            hitCycleCap = true;
            continue;
          }

          final nextMoves = [...node.moves, move];
          if (_objectiveChecker.isSolved(level, nextBoard)) {
            return SolverResult(
              solved: true,
              moves: nextMoves,
              minimumMoves: nextMoves.length,
              exploredStates: explored,
            );
          }

          final nextHash = nextBoard.toFlatHash();
          if (!visited.contains(nextHash)) {
            queue.add(_SearchNode(board: nextBoard, moves: nextMoves));
          }
        }
      }
    }

    return SolverResult(
      solved: false,
      moves: const [],
      minimumMoves: 0,
      hitDepthCap: true,
      hitCycleCap: hitCycleCap,
      exploredStates: explored,
    );
  }

  SolverResult _solveAStar(LevelModel level, int depthCap, int maxStates) {
    final visited = <String, int>{};
    var explored = 0;
    var hitCycleCap = false;

    final open = HeapPriorityQueue<_ScoredNode>(
      (a, b) => a.fScore.compareTo(b.fScore),
    );

    final start = _SearchNode(board: level.board, moves: const []);
    open.add(
      _ScoredNode(
        node: start,
        gScore: 0,
        fScore: _heuristic(level, start.board),
      ),
    );

    while (open.isNotEmpty) {
      if (explored >= maxStates) {
        return SolverResult(
          solved: false,
          moves: const [],
          minimumMoves: 0,
          hitDepthCap: true,
          hitCycleCap: hitCycleCap,
          exploredStates: explored,
        );
      }
      final current = open.removeFirst();
      explored++;

      final hash = current.node.board.toFlatHash();
      final prior = visited[hash];
      if (prior != null && prior <= current.gScore) {
        continue;
      }
      visited[hash] = current.gScore;

      if (current.gScore >= depthCap) {
        continue;
      }

      for (final tile in current.node.board.tiles.where((t) => t.isMovable)) {
        for (final move in _engine.legalMoves(current.node.board, tile.id)) {
          final (nextBoard, cycleCap) = _applyMove(current.node.board, move);
          if (cycleCap) {
            hitCycleCap = true;
            continue;
          }

          final nextMoves = [...current.node.moves, move];
          if (_objectiveChecker.isSolved(level, nextBoard)) {
            return SolverResult(
              solved: true,
              moves: nextMoves,
              minimumMoves: nextMoves.length,
              exploredStates: explored,
            );
          }

          final gScore = current.gScore + 1;
          final nextHash = nextBoard.toFlatHash();
          final best = visited[nextHash];
          if (best != null && best <= gScore) {
            continue;
          }

          open.add(
            _ScoredNode(
              node: _SearchNode(board: nextBoard, moves: nextMoves),
              gScore: gScore,
              fScore: gScore + _heuristic(level, nextBoard),
            ),
          );
        }
      }
    }

    return SolverResult(
      solved: false,
      moves: const [],
      minimumMoves: 0,
      hitDepthCap: true,
      hitCycleCap: hitCycleCap,
      exploredStates: explored,
    );
  }

  (BoardModel board, bool hitCycleCap) _applyMove(BoardModel board, Move move) {
    if (!board.canAcceptPlayerMove(move)) {
      return (board, false);
    }
    final afterPlayer = _applier.applyPlayerMove(board, move);
    final result = _engine.simulate(afterPlayer);
    return (result.finalBoard, result.hitCycleCap);
  }

  double _heuristic(LevelModel level, BoardModel board) {
    return switch (level.objective) {
      PositionObjective(:final tileId, :final goalRow, :final goalCol) => () {
          final tile = board.tileById(tileId);
          if (tile == null) {
            return 1000.0;
          }
          return (tile.row - goalRow).abs() + (tile.col - goalCol).abs() +
              0.0;
        }(),
      _ => 0.0,
    };
  }
}

class _SearchNode {
  const _SearchNode({required this.board, required this.moves});

  final BoardModel board;
  final List<Move> moves;
}

class _ScoredNode {
  const _ScoredNode({
    required this.node,
    required this.gScore,
    required this.fScore,
  });

  final _SearchNode node;
  final int gScore;
  final double fScore;
}

/// Minimal binary heap for A* open set.
class HeapPriorityQueue<T> {
  HeapPriorityQueue(this.compare);

  final int Function(T a, T b) compare;
  final List<T> _heap = [];

  bool get isNotEmpty => _heap.isNotEmpty;

  void add(T value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  T removeFirst() {
    final first = _heap.first;
    final last = _heap.removeLast();
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }
    return first;
  }

  void _bubbleUp(int index) {
    while (index > 0) {
      final parent = (index - 1) ~/ 2;
      if (compare(_heap[index], _heap[parent]) >= 0) {
        break;
      }
      final tmp = _heap[parent];
      _heap[parent] = _heap[index];
      _heap[index] = tmp;
      index = parent;
    }
  }

  void _bubbleDown(int index) {
    final length = _heap.length;
    while (true) {
      final left = 2 * index + 1;
      final right = 2 * index + 2;
      var smallest = index;

      if (left < length &&
          compare(_heap[left], _heap[smallest]) < 0) {
        smallest = left;
      }
      if (right < length &&
          compare(_heap[right], _heap[smallest]) < 0) {
        smallest = right;
      }
      if (smallest == index) {
        break;
      }
      final tmp = _heap[smallest];
      _heap[smallest] = _heap[index];
      _heap[index] = tmp;
      index = smallest;
    }
  }
}
