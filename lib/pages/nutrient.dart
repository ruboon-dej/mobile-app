// lib/pages/nutrient.dart
import 'package:flutter/material.dart';

class NutrientPage extends StatelessWidget {
  const NutrientPage({super.key});

  @override
  Widget build(BuildContext context) {
    // demo nutrient splits (sum to 1.0)
    final current = const [
      _Slice(0.45, Color(0xFF66BB6A), 'Veg/Fruit'), // green
      _Slice(0.33, Color(0xFF42A5F5), 'Carb'),      // blue
      _Slice(0.22, Color(0xFFFF7043), 'Protein'),   // orange
    ];
    final goal = const [
      _Slice(0.48, Color(0xFF66BB6A), 'Veg/Fruit'),
      _Slice(0.30, Color(0xFF42A5F5), 'Carb'),
      _Slice(0.22, Color(0xFFFF7043), 'Protein'),
    ];

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Text('Nutrient',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                  child: Image.asset('assets/icons/Pencil.png', width: 26, height: 26),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),

            // Two pies
            Row(
              children: [
                Expanded(
                  child: _PieCard(
                    title: 'current nutrient',
                    slices: current,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _PieCard(
                    title: 'goal nutrient',
                    slices: goal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Suggestions
            Text('Suggestion',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const _SuggestionLine(
              text: 'Eat more fruit and vegetable',
              color: Color(0xFF43A047), // green
            ),
            const _SuggestionLine(
              text: 'Eat less carbohydrate, protein, and fats',
              color: Color(0xFFD32F2F), // red
            ),
            const SizedBox(height: 18),

            // History
            Row(
              children: [
                Text('History',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(width: 8),
                Image.asset('assets/icons/Pencil.png', width: 20, height: 20),
              ],
            ),
            const SizedBox(height: 10),
            _HistoryTile(
              title: 'Seafood Paella',
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Open: Seafood Paella'))),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- Pie chart ---------------- */

class _PieCard extends StatelessWidget {
  final String title;
  final List<_Slice> slices;
  const _PieCard({required this.title, required this.slices});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1, // square pie
          child: CustomPaint(painter: _PiePainter(slices)),
        ),
        const SizedBox(height: 6),
        Text(title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}

class _Slice {
  final double fraction; // 0..1
  final Color color;
  final String label;
  const _Slice(this.fraction, this.color, this.label);
}

class _PiePainter extends CustomPainter {
  final List<_Slice> slices;
  _PiePainter(this.slices);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()..style = PaintingStyle.fill;

    double start = -90 * 3.1415926535 / 180; // start at top
    for (final s in slices) {
      final sweep = s.fraction * 2 * 3.1415926535;
      paint.color = s.color;
      canvas.drawArc(rect, start, sweep, true, paint);
      start += sweep;
    }

    // white donut hole (for a cute look)
    final hole = Paint()..color = Colors.white;
    final r = size.width * 0.32;
    canvas.drawCircle(size.center(Offset.zero), r, hole);
  }

  @override
  bool shouldRepaint(covariant _PiePainter old) => old.slices != slices;
}

/* ---------------- Suggestions ---------------- */

class _SuggestionLine extends StatelessWidget {
  final String text;
  final Color color;
  const _SuggestionLine({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/* ---------------- History tile (uses your box image) ---------------- */

class _HistoryTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _HistoryTile({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 800 / 300, // match your TaskBox.png ratio
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/TaskBox.png', fit: BoxFit.fill),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0C0C0C),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }
}
