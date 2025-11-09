import 'package:flutter/material.dart';

import 'calendar.dart'; // ✅ add this line
import 'diary.dart';
// import 'pages/today_page.dart'; // when you have real pages, use them here

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  // Replace these stubs with your real pages, e.g., TodayPage(), NutrientPage()...
  final _tabs = const [
    _PageStub('Task / Today'),
    _PageStub('Nutrient'),
    _PageStub('Goal'),
     CalendarPage(),
     DiaryPage(), 
  ];

  void _goTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final headerH = screenW * 146 / 1080; // Top.png ratio
    final barH    = screenW * 226 / 1080; // ⬅️ Bottom.png ratio

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headerH),
        child: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          flexibleSpace: ClipRRect(
  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
  child: Stack(
    fit: StackFit.expand,
    children: [
      // header image (unchanged)
      Image.asset(
        'assets/images/Top.png',
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
        width: screenW,
        height: headerH,
      ),

      // ✅ profile button (top-right)
      Positioned(
        right: 12,   // tweak to match your art
        top: 20,      // tweak to match your art
        child: GestureDetector(
          onTap: () {
            // later: replace with pushNamed('/profile') if you add a route
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const _PageStub('Profile')),
            );
          },
          child: Image.asset(
            'assets/icons/Profile.png',
            width: 48,   // keeps it square; 48x48 looks good for a 201x200 source
            height: 48,  // adjust if you want bigger/smaller
          ),
        ),
      ),
    ],
  ),
),
        ),
      ),

      drawer: Drawer(
        // ...unchanged...
      ),

      body: IndexedStack(index: _index, children: _tabs),

      // ⬇️ REPLACED: show Bottom.png behind the NavigationBar
      bottomNavigationBar: SizedBox(
        height: barH,
        child: Stack(
          children: [
            // background image (keeps aspect ratio and fills width)
            Positioned.fill(
              child: Image.asset(
                'assets/images/Bottom.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              ),
            // the actual nav bar, transparent over the image
            Align(
              alignment: Alignment.topCenter,
              child: NavigationBarTheme(
                data: const NavigationBarThemeData(
                  backgroundColor: Colors.transparent,
                  indicatorColor: Color(0xFFE6DEFF), // optional purple pill
                  elevation: 0,
                  height: 72,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: NavigationBar(
                    selectedIndex: _index,
                  onDestinationSelected: _goTab,
                  destinations: [
                    NavigationDestination(
                      icon: Image.asset('assets/icons/task.png', width: 28, height: 28),
                      selectedIcon: Image.asset('assets/icons/task.png', width: 28, height: 28),
                      label: 'Task',
                    ),
                    NavigationDestination(
                      icon: Image.asset('assets/icons/Nutrients.png', width: 28, height: 28),
                      selectedIcon: Image.asset('assets/icons/Nutrients.png', width: 28, height: 28),
                      label: 'Nutrient',
                    ),
                    NavigationDestination(
                      icon: Image.asset('assets/icons/Goal.png', width: 28, height: 28),
                      selectedIcon: Image.asset('assets/icons/Goal.png', width: 28, height: 28),
                      label: 'Goal',
                    ),
                    NavigationDestination(
                      icon: Image.asset('assets/icons/Calendar.png', width: 28, height: 28),
                      selectedIcon: Image.asset('assets/icons/Calendar.png', width: 28, height: 28),
                      label: 'Calendar',
                    ),
                    NavigationDestination(
                      icon: Image.asset('assets/icons/Diary.png', width: 28, height: 28),
                      selectedIcon: Image.asset('assets/icons/Diary.png', width: 28, height: 28),
                      label: 'Diary',
                    ),
                  ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

/// Temporary placeholder; swap each with your real page (e.g., TodayPage).
class _PageStub extends StatelessWidget {
  final String label;
  const _PageStub(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
