// Source:https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:student_application/project-tab-scaffold.dart';

import 'screens/access-screen.dart';
import 'screens/project-screen.dart';
import 'screens/project-entry-screen.dart';
import 'screens/error-screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: AccessScreen(),
      routes: {
        AccessScreen.routeName: (ctx) => AccessScreen(),
        ProjectNavigationScaffold.routeName: (ctx) => ProjectNavigationScaffold(),
        ErrorScreen.routeName: (ctx) => ErrorScreen()
        // ProjectScreen.routeName: (ctx) => ProjectScreen(),
        // ProjectEntryScreen.routeName: (ctx) => ProjectEntryScreen(),
        // ProjectEmailScreen.routeName: (ctx) => ProjectEmailScreen()
      });
  }
}
