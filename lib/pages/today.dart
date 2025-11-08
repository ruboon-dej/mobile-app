import 'dart:io';
import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});
  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  int _tab = 0;

  // Demo items (replace with your data later)
  final List<_Task> _tasks = const [
    _Task(
      title: 'Blender project',
      time: '08:30',
      // Put a real asset here, or keep null to see the gradient fallback
      imagePath: 'assets/images/pink.png',
      colorHex: 0xFFFF5252, // red
    ),
    _Task(
      title: 'Computer Network',
      time: '12:00',
      imagePath: 'assets/images/pink.png',
      colorHex: 0xFFFFA726, // orange
    ),
    _Task(
      title: 'Write Diary',
      time: null,
      imagePath: null,      // shows gradient fallback
      colorHex: 0xFF42A5F5, // blue
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PAGE BODY
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: "Today" + edit + profile
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
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      // later: open add/edit sheet
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit tapped')),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  const Spacer(),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Tiles list
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: _tasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, i) {
                    final t = _tasks[i];
                    return _TaskTile(
                      title: t.title,
                      time: t.time,
                      imagePath: t.imagePath,
                      dotColor: Color(t.colorHex),
                      onTap: () {
                        // later: navigate to detail
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
      ),

      // Bottom nav (static for now)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Task'),
          NavigationDestination(icon: Icon(Icons.restaurant), label: 'Nutrient'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Goal'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Diary'),
        ],
      ),
    );
  }
}

// === Tile ===

class _TaskTile extends StatelessWidget {
  final String title;
  final String? time;
  final String? imagePath; // asset path or absolute file path; null -> gradient
  final Color dotColor;
  final VoidCallback? onTap;

  const _TaskTile({
    required this.title,
    required this.dotColor,
    this.time,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 5, // wide tile like the sketch
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background: try asset/file if provided, else gradient
            if (imagePath != null)
              _SmartBg(path: imagePath!)
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [dotColor, Colors.black54],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            // Dark overlay to keep text readable
            Container(color: Colors.black.withOpacity(0.25)),
            // Content row: dot • title • time
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        height: 1.0,
                      ),
                    ),
                  ),
                  if (time != null)
                    Text(
                      time!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
            // Tap effect / handler
            Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ],
        ),
      ),
    );
  }
}

// Tries to load an asset first; if the string points to a file path that exists, uses Image.file.
// This lets you later switch to real file paths without changing the UI.
class _SmartBg extends StatelessWidget {
  final String path;
  const _SmartBg({required this.path});

  @override
  Widget build(BuildContext context) {
    // If it's an absolute path and exists -> file
    if ((path.startsWith('/') || path.contains(':')) && File(path).existsSync()) {
      return Image.file(File(path), fit: BoxFit.cover);
    }
    // Otherwise treat as asset
    return Image.asset(path, fit: BoxFit.cover);
  }
}

// === simple demo model ===
class _Task {
  final String title;
  final String? time;
  final String? imagePath;
  final int colorHex;
  const _Task({
    required this.title,
    this.time,
    this.imagePath,
    required this.colorHex,
  });
}
