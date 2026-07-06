import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../levels/daily_puzzle_generator.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_scaffold.dart';

class DailyPuzzleScreen extends StatelessWidget {
  DailyPuzzleScreen({super.key});

  final _generator = DailyPuzzleGenerator();

  @override
  Widget build(BuildContext context) {
    final puzzle = _generator.generateForDate(DateTime.now());

    return NGScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Puzzle', style: Theme.of(context).textTheme.headlineMedium),
            Text('Seed: ${puzzle.id}'),
            Text('Board: ${puzzle.board.rows}×${puzzle.board.cols}'),
            const Spacer(),
            NGButton(
              label: 'Play Daily',
              onPressed: () => context.go('/play/${puzzle.id}'),
            ),
          ],
        ),
      ),
    );
  }
}
