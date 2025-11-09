import 'package:flutter/material.dart';
import 'package:mobile_app_project/pages/goal.dart';
import 'pages/home_screen.dart';
import 'pages/profile.dart';
import 'pages/today.dart';
import 'pages/nutrient.dart';
import 'pages/diary.dart';
import 'pages/calendar.dart';
//Task01: import page1,2,3,4,5
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Named Routes',
      initialRoute: '/',
      //Task02: define routing
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/today': (context) => const TodayPage(),
        '/nutrient': (context) => const NutrientPage(),
        '/diary': (context) => const DiaryPage(),
        '/calendar': (context) => const CalendarPage(),
        '/goal': (context) => const GoalPage(),
      },
    );
  }
}



