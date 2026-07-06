import 'package:flutter/material.dart';

import '../../services/leaderboard/leaderboard_service.dart';
import '../../widgets/common/ng_scaffold.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({required this.service, super.key});

  final LeaderboardService service;

  @override
  Widget build(BuildContext context) {
    return NGScaffold(
      body: FutureBuilder(
        future: service.fetchGlobal(),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? const [];
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                title: Text(entry.displayName),
                trailing: Text('${entry.score}'),
              );
            },
          );
        },
      ),
    );
  }
}
