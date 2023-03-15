import 'package:flutter/material.dart';

import './models/project.dart';
import './models/student.dart';
import './models/futures.dart';

import 'screens/project-screen.dart';
import 'screens/project-entry-screen.dart';
import 'screens/project-email-screen.dart';

class ProjectNavigationScaffold extends StatefulWidget {
  static const routeName = '/tab';
  ProjectNavigationScaffold({super.key});

  @override
  State<ProjectNavigationScaffold> createState() =>
      _ProjectNavigationScaffoldState();
}

class _ProjectNavigationScaffoldState extends State<ProjectNavigationScaffold> {
  @override
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<String> _titleOptions = [
    'Project Description',
    'Collect Data'
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accessCode = ModalRoute.of(context)!.settings.arguments;
    print(accessCode);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleOptions.elementAt(_selectedIndex)),
      ),
      body: Center(
        // child: _widgetOptions.elementAt(_selectedIndex),
        child: FutureBuilder<List<Widget>>(
          future: getScreenList(accessCode),
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            // WHILE THE CALL IS BEING MADE AKA LOADING
            if (ConnectionState.active != null && !snapshot.hasData) {
              return Center(child:
                CircularProgressIndicator(
                  strokeWidth: 10,
                  )
              );
            }

            // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
            if (ConnectionState.done != null && snapshot.hasError) {
              return Center(child: Text("ERROR"));
            }
            return snapshot.data!.elementAt(_selectedIndex);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt_rounded),
            label: 'Data',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
