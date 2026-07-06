import 'package:flutter/material.dart';

/// Animation duration constants (Section 11).
class AppAnimations {
  AppAnimations._();

  static const Duration cycleStep = Duration(milliseconds: 200);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 700);

  static const Curve standardCurve = Curves.easeInOutCubic;
}
