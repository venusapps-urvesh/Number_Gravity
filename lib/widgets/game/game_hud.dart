import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/game_session_provider.dart';

class GameHud extends StatelessWidget {
  const GameHud({
    required this.session,
    required this.onUndo,
    required this.onRestart,
    required this.onPause,
    super.key,
  });

  final GameSessionState session;
  final VoidCallback onUndo;
  final VoidCallback onRestart;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text('Moves: ${session.movesUsed}'),
          const Spacer(),
          IconButton(
            tooltip: 'Undo',
            onPressed: onUndo,
            icon: const Icon(Icons.undo_rounded),
          ),
          IconButton(
            tooltip: 'Restart',
            onPressed: onRestart,
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            tooltip: l10n.settings,
            onPressed: onPause,
            icon: const Icon(Icons.pause_rounded),
          ),
        ],
      ),
    );
  }
}
