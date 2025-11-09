// lib/pages/goal.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key, this.progress = 0.50});

  /// Progress in 0.0–1.0
  final double progress;

  @override
  Widget build(BuildContext context) {
    final pct = (progress.clamp(0.0, 1.0) * 100).round();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Text(
                  'Goal',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                  child: Image.asset('assets/icons/Pencil.png', width: 26, height: 26),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 24),

            // Circular progress
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (_, c) {
                    final size = c.biggest.shortestSide * 0.75; // responsive
                    return SizedBox(
                      width: size,
                      height: size,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size.square(size),
                            painter: _RingPainter(progress),
                          ),
                          Text(
                            '$pct%',
                            style: const TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0C0C0C),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Caption
            Center(
              child: Text(
                'You are $pct% of your goal',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0C0C0C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- Painter for the ring ---------------- */

class _RingPainter extends CustomPainter {
  final double progress; // 0..1
  _RingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // Colors/thickness (tweak to match your palette)
    const bgColor = Color(0xFFEED9E9); // light pink ring
    const fgColor = Color(0xFF1C2BFF); // deep blue progress
    const knobColor = Color(0xFF1C2BFF);
    final stroke = radius * 0.12;

    // Background ring
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = bgColor;
    canvas.drawCircle(center, radius - stroke / 2, base);

    // Progress arc
    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    final start = -math.pi / 2; // 12 o’clock
    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = fgColor;

    final rect = Rect.fromCircle(center: center, radius: radius - stroke / 2);
    canvas.drawArc(rect, start, sweep, false, fg);

    // Knob at the end
    final endAngle = start + sweep;
    final knobR = stroke * 0.55;
    final endOffset = Offset(
      center.dx + (radius - stroke / 2) * math.cos(endAngle),
      center.dy + (radius - stroke / 2) * math.sin(endAngle),
    );
    canvas.drawCircle(endOffset, knobR, Paint()..color = knobColor);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
