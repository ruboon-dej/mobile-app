import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
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
        '/': (context) => HomePage(),
        '/page1': (context) => HomePage(),
        '/page2': (context) => HomePage(),
        '/page3': (context) => HomePage(),
        '/page4': (context) => HomePage(),
        '/page5': (context) => HomePage(),
      },
    );
  }
}



