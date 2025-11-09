import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // pubspec: table_calendar ^3.0.9

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  // Tabs: swap only the Calendar slot to a real calendar page
  final _tabs = const [
    _PageStub('Task / Today'),
    _PageStub('Nutrient'),
    _PageStub('Goal'),
    CalendarPage(), 
    _PageStub('Diary'),
  ];

  void _goTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final headerH = screenW * 146 / 1080; // Top.png ratio
    final barH    = screenW * 226 / 1080; // Bottom.png ratio

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
                Image.asset(
                  'assets/images/Top.png',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  width: screenW,
                  height: headerH,
                ),
                Positioned(
                  right: 12,
                  top: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const _PageStub('Profile')),
                      );
                    },
                    child: Image.asset(
                      'assets/icons/Profile.png',
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      drawer: const Drawer(), // your real drawer later

      body: IndexedStack(index: _index, children: _tabs),

      bottomNavigationBar: SizedBox(
        height: barH,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/Bottom.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: NavigationBarTheme(
                data: const NavigationBarThemeData(
                  backgroundColor: Colors.transparent,
                  indicatorColor: Color(0xFFE6DEFF),
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

/// Temporary placeholder page
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

/// Calendar page: tap selects/highlights a day (no further action yet)
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay:  DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) =>
                _selectedDay != null && isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; 
                _focusedDay  = focusedDay;
              });
            },
            onPageChanged: (newFocused) => _focusedDay = newFocused,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              outsideDaysVisible: false,
            ),
            availableGestures: AvailableGestures.horizontalSwipe,
          ),
        ),
      ),
    );
  }
}
