import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/game_constants.dart';
import '../../l10n/app_localizations.dart';

class WinOverlay extends StatefulWidget {
  const WinOverlay({
    required this.movesUsed,
    required this.minimumMoves,
    required this.onLevels,
    required this.onNextLevel,
    required this.onReplay,
    this.reduceMotion = false,
    super.key,
  });

  final int movesUsed;
  final int minimumMoves;
  final VoidCallback onLevels;
  final VoidCallback onNextLevel;
  final VoidCallback onReplay;
  final bool reduceMotion;

  @override
  State<WinOverlay> createState() => _WinOverlayState();
}

class _WinOverlayState extends State<WinOverlay> with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _pulseController;
  late final AnimationController _confettiController;
  late final Animation<double> _entryOpacity;
  late final Animation<double> _entryScale;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.reduceMotion ? 120 : 520),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.reduceMotion ? 1600 : 900),
    );
    _confettiController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.reduceMotion ? 2400 : 1800),
    );
    _entryOpacity = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutCubic,
    );
    _entryScale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
    );
    _entryController.forward();
    if (!widget.reduceMotion) {
      _pulseController.repeat(reverse: true);
      _confettiController.repeat();
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stars = starsForMoves(
      movesUsed: widget.movesUsed,
      minimumMoves: widget.minimumMoves,
    );
    final brightness = Theme.of(context).brightness;
    final surface = brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    return FadeTransition(
      opacity: _entryOpacity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: ColoredBox(color: Colors.black.withValues(alpha: 0.62)),
            ),
          ),
          if (!widget.reduceMotion)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _confettiController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _ConfettiPainter(_confettiController.value),
                    );
                  },
                ),
              ),
            ),
          Center(
            child: ScaleTransition(
              scale: _entryScale,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goal.withValues(alpha: 0.35),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (!widget.reduceMotion)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: _CelebrationPainter(
                                  _pulseController.value,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.levelComplete,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.goal,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            final scale = widget.reduceMotion
                                ? 1.0
                                : 1.0 + (_pulseController.value * 0.06);
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: SizedBox(
                            width: 88,
                            height: 88,
                            child: SvgPicture.asset(
                              'assets/images/trophy_best.svg',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            final filled = index < stars;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Icon(
                                filled
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: filled
                                    ? AppColors.goal
                                    : AppColors.neutral400,
                                size: 34,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.movesOptimal(
                            widget.movesUsed,
                            widget.minimumMoves,
                          ),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _IconActionButton(
                              icon: Icons.grid_view_rounded,
                              onPressed: widget.onLevels,
                              tooltip: l10n.levels,
                            ),
                            _IconActionButton(
                              icon: Icons.restart_alt_rounded,
                              onPressed: widget.onReplay,
                              tooltip: l10n.replay,
                            ),
                            _IconActionButton(
                              icon: Icons.skip_next_rounded,
                              onPressed: widget.onNextLevel,
                              tooltip: l10n.nextLevel,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  const _IconActionButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.goal.withValues(alpha: 0.14),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.goal.withValues(alpha: 0.35),
              width: 1.2,
            ),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Icon(icon, color: AppColors.goal, size: 28),
          ),
        ),
      ),
    );
  }
}

class _CelebrationPainter extends CustomPainter {
  const _CelebrationPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    const points = [
      Offset(0.12, 0.24),
      Offset(0.22, 0.1),
      Offset(0.82, 0.15),
      Offset(0.9, 0.3),
      Offset(0.86, 0.78),
      Offset(0.16, 0.74),
    ];
    for (var i = 0; i < points.length; i++) {
      final p = points[i];
      final t = (progress + (i * 0.14)) % 1.0;
      final radius = 2.5 + (2.8 * (1 - (t - 0.5).abs() * 2).clamp(0.0, 1.0));
      paint.color = AppColors.goal.withValues(alpha: 0.18 + (0.38 * t));
      canvas.drawCircle(
        Offset(size.width * p.dx, size.height * p.dy),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CelebrationPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter(this.progress);

  final double progress;

  static const _xSlots = <double>[
    0.08,
    0.14,
    0.2,
    0.28,
    0.36,
    0.44,
    0.52,
    0.6,
    0.68,
    0.76,
    0.84,
    0.92,
  ];

  static const _speeds = <double>[
    0.75,
    0.88,
    0.97,
    0.82,
    0.93,
    0.78,
    0.9,
    0.84,
    0.98,
    0.8,
    0.94,
    0.86,
  ];

  static const _drifts = <double>[
    -0.025,
    0.03,
    -0.02,
    0.018,
    -0.03,
    0.024,
    -0.018,
    0.03,
    -0.022,
    0.02,
    -0.028,
    0.026,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < _xSlots.length; i++) {
      final speed = _speeds[i];
      final local = (progress * speed + (i * 0.08)) % 1.0;
      final y = (local * 1.2 - 0.15) * size.height;
      final x =
          (_xSlots[i] + (_drifts[i] * (0.5 - (local - 0.5).abs()))) *
          size.width;
      final alpha = (1 - (local - 0.5).abs() * 1.4).clamp(0.0, 1.0);
      final color = switch (i % 4) {
        0 => Colors.amber,
        1 => Colors.orangeAccent,
        2 => Colors.white,
        _ => const Color(0xFFFFE082),
      };
      paint.color = color.withValues(alpha: 0.22 + (0.5 * alpha));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, y), width: 5.5, height: 10),
          const Radius.circular(2.2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
