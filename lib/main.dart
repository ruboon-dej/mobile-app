import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/profile.dart';
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
        '/profile': (context) => const ProfilePage(), // ✅ parentheses and const
      },
    );
  }
}



