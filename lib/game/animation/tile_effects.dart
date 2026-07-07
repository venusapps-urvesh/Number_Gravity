import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../components/tile_component.dart';

class _EffectCompleter {
  final _completer = Completer<void>();

  Future<void> get future => _completer.future;

  void complete() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }
}

/// Applies a brief scale pulse for collision feedback.
void playCollisionPulse(TileComponent tile) {
  tile.removeWhere((c) => c is ScaleEffect || c is SequenceEffect);
  tile.scale = Vector2.all(1);
  tile.add(
    SequenceEffect([
      ScaleEffect.to(
        Vector2.all(1.18),
        EffectController(duration: 0.08, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.12, curve: Curves.easeIn),
      ),
    ]),
  );
}

/// Shrinks a tile out (annihilation / portal exit).
Future<void> playFadeOut(TileComponent tile, {double duration = 0.15}) {
  tile.removeWhere((c) => c is ScaleEffect);
  tile.scale = Vector2.all(1);
  final tracker = _EffectCompleter();
  tile.add(
    ScaleEffect.to(
      Vector2.zero(),
      EffectController(duration: duration, curve: Curves.easeIn),
      onComplete: tracker.complete,
    ),
  );
  return tracker.future;
}

/// Grows a tile in (portal entry).
Future<void> playFadeIn(TileComponent tile, {double duration = 0.15}) {
  tile.removeWhere((c) => c is ScaleEffect);
  tile.scale = Vector2.zero();
  final tracker = _EffectCompleter();
  tile.add(
    ScaleEffect.to(
      Vector2.all(1),
      EffectController(duration: duration, curve: Curves.easeOut),
      onComplete: tracker.complete,
    ),
  );
  return tracker.future;
}

/// Selection scale when a tile is highlighted.
void playSelectionScale(TileComponent tile, {required bool selected}) {
  tile.removeWhere((c) => c is ScaleEffect);
  if (selected) {
    tile.add(
      ScaleEffect.to(
        Vector2.all(1.08),
        EffectController(duration: 0.12, curve: Curves.easeOut),
      ),
    );
  } else {
    tile.add(
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.1, curve: Curves.easeIn),
      ),
    );
  }
}

/// Goal glow pulse when objective tile reaches the goal.
void playGoalGlow(TileComponent goalTile) {
  goalTile.glowing = true;
  goalTile.removeWhere((c) => c is ScaleEffect || c is SequenceEffect);
  goalTile.scale = Vector2.all(1);
  goalTile.add(
    SequenceEffect([
      ScaleEffect.to(
        Vector2.all(1.12),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.2, curve: Curves.easeIn),
      ),
    ]),
  );
}

/// Moves a tile component smoothly to a world position.
Future<void> playMoveTo(
  TileComponent tile,
  Vector2 target, {
  required double duration,
}) {
  tile.removeWhere((c) => c is MoveEffect);
  final tracker = _EffectCompleter();
  tile.add(
    MoveEffect.to(
      target,
      EffectController(duration: duration, curve: Curves.easeInOut),
      onComplete: tracker.complete,
    ),
  );
  return tracker.future;
}
