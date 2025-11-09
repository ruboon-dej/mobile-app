// lib/pages/today.dart
import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = const [
      _TaskModel(
        title: 'Blender project',
        urgencyColor: Color(0xFFE53935), // red
        boxImage: 'assets/images/TaskBox.png', // <-- your box image
      ),
      _TaskModel(
        title: 'Computer Network',
        urgencyColor: Color(0xFFFFB300), // amber
        boxImage: 'assets/images/TaskBox.png',
      ),
    ];

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: Today + pencil button
            Row(
              children: [
                Text(
                  'Today',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                  child: Image.asset(
                    'assets/icons/Pencil.png', // <-- your pencil image
                    width: 28,
                    height: 28,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),

            // Task tiles
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (context, i) {
                  final t = tasks[i];
                  return _TaskTile(
                    title: t.title,
                    boxImage: t.boxImage,
                    urgencyColor: t.urgencyColor,
                    onTap: () {
                      // later: open task detail
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Open: ${t.title}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------ widgets ------------ */

class _TaskTile extends StatelessWidget {
  final String title;
  final String boxImage;      // the rectangle frame image
  final Color urgencyColor;   // the colored dot (not an image)
  final VoidCallback? onTap;

  const _TaskTile({
    required this.title,
    required this.boxImage,
    required this.urgencyColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 800 / 300, // adjust to match your box image proportions
      child: Stack(
        children: [
          // Box image as background
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(boxImage, fit: BoxFit.cover),
            ),
          ),
          // Content on top: urgency dot + title
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  _UrgencyDot(color: urgencyColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0C0C0C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tap effect
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }
}

class _UrgencyDot extends StatelessWidget {
  final Color color;
  const _UrgencyDot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/* ------------ data model ------------ */

class _TaskModel {
  final String title;
  final Color urgencyColor;
  final String boxImage;
  const _TaskModel({
    required this.title,
    required this.urgencyColor,
    required this.boxImage,
  });
}
