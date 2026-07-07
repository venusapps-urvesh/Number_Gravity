import 'dart:convert';
import 'dart:io';
import 'dart:ui' show ImageByteFormat;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/core/constants/board_constants.dart';
import 'package:number_gravity/game/bridges/simulation_bridge.dart';
import 'package:number_gravity/game/layout/board_layout.dart';
import 'package:number_gravity/game/number_gravity_game.dart';
import 'package:number_gravity/levels/daily_puzzle_generator.dart';
import 'package:number_gravity/levels/level_loader.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';

Future<LevelModel> _loadLevelFromWorld(int worldFile, int index) async {
  final raw = File(
    'assets/levels/world_${worldFile.toString().padLeft(2, '0')}.json',
  ).readAsStringSync();
  final json = jsonDecode(raw) as Map<String, dynamic>;
  final levels = json['levels'] as List<dynamic>;
  return LevelLoader().parseLevel(levels[index] as Map<String, dynamic>);
}

Future<(int bluePixels, int goldPixels)> _countBoardPixels(
  WidgetTester tester,
) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byType(RepaintBoundary).first,
  );
  final image = await tester.runAsync(() => boundary.toImage());
  final bytes = await tester.runAsync(
    () => image!.toByteData(format: ImageByteFormat.rawRgba),
  );
  final data = bytes!.buffer.asUint8List();
  var bluePixels = 0;
  var goldPixels = 0;
  for (var i = 0; i < data.length; i += 4) {
    final r = data[i];
    final g = data[i + 1];
    final b = data[i + 2];
    if (b > 180 && r < 100 && g < 140) bluePixels++;
    if (r > 200 && g > 140 && b < 100) goldPixels++;
  }
  return (bluePixels, goldPixels);
}

Future<void> _pumpGameplayBoard(
  WidgetTester tester, {
  required LevelModel level,
  required Size viewport,
}) async {
  final game = NumberGravityGame(
    bridge: SimulationBridge(
      engine: DefaultGravityEngine(),
      applier: BoardApplier(),
    ),
    level: level,
  );

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 80, child: Placeholder()),
              const SizedBox(height: 24, child: Placeholder()),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final layout = BoardLayout.fit(
                      rows: level.board.rows,
                      cols: level.board.cols,
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight,
                    );
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      game.applyLayout(
                        viewportWidth: constraints.maxWidth,
                        viewportHeight: constraints.maxHeight,
                      );
                    });
                    return Center(
                      child: SizedBox(
                        width: layout.boardWidth,
                        height: layout.boardHeight,
                        child: GameWidget(game: game),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 68, child: Placeholder()),
            ],
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('BoardLayout fits 4x4 through 8x8 inside viewport', () {
    const viewport = Size(360, 360);

    double? previousCellSize;
    for (final size in [4, 6, 8]) {
      final layout = BoardLayout.fit(
        rows: size,
        cols: size,
        maxWidth: viewport.width,
        maxHeight: viewport.height,
      );

      expect(layout.boardWidth, lessThanOrEqualTo(viewport.width));
      expect(layout.boardHeight, lessThanOrEqualTo(viewport.height));
      expect(layout.cellSize, greaterThan(0));
      if (previousCellSize != null) {
        expect(
          layout.cellSize,
          lessThan(previousCellSize!),
          reason: 'larger grids should use smaller cells',
        );
      }
      previousCellSize = layout.cellSize;
    }
  });

  test('BoardLayout scales 4x4 cells larger than fixed design size', () {
    const viewport = Size(360, 500);
    final layout = BoardLayout.fit(
      rows: 4,
      cols: 4,
      maxWidth: viewport.width,
      maxHeight: viewport.height,
    );

    expect(layout.cellSize, greaterThan(tileSizePx));
  });

  testWidgets('4x4 board renders inside gameplay column layout', (tester) async {
    final level = await _loadLevelFromWorld(1, 0);
    await _pumpGameplayBoard(
      tester,
      level: level,
      viewport: const Size(360, 400),
    );

    final (bluePixels, goldPixels) = await _countBoardPixels(tester);

    expect(bluePixels, greaterThan(0), reason: 'positive tile should render');
    expect(goldPixels, greaterThan(0), reason: 'goal tile should render');
  });

  testWidgets('8x8 board fits inside phone viewport', (tester) async {
    final level = await _loadLevelFromWorld(8, 24);
    expect(level.board.rows, 8);
    expect(level.board.cols, 8);

    await _pumpGameplayBoard(
      tester,
      level: level,
      viewport: const Size(360, 400),
    );

    final layout = BoardLayout.fit(
      rows: 8,
      cols: 8,
      maxWidth: 360,
      maxHeight: 240,
      padding: 16,
    );
    expect(layout.boardWidth, lessThanOrEqualTo(360));
    expect(layout.boardHeight, lessThanOrEqualTo(240));
    expect(layout.cellSize, greaterThan(16));
  });

  testWidgets('daily puzzle board renders tiles and goal', (tester) async {
    final level = DailyPuzzleGenerator().generateForDate(DateTime(2026, 7, 7));
    await _pumpGameplayBoard(
      tester,
      level: level,
      viewport: const Size(360, 400),
    );

    final (bluePixels, goldPixels) = await _countBoardPixels(tester);

    expect(bluePixels, greaterThan(0), reason: 'daily number tile should render');
    expect(goldPixels, greaterThan(0), reason: 'daily goal tile should render');
  });
}
