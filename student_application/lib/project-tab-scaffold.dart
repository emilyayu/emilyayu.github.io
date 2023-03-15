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
    'Collect Data',
    'Email a Question'
  ];

  static List<Widget> _widgetOptions = <Widget>[
    // ProjectScreen(project: _project),
    // ProjectEntryScreen(widget.students),
    ProjectEmailScreen(),
    ProjectEmailScreen(),
    ProjectEmailScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accessCode = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titleOptions.elementAt(_selectedIndex)),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
        // child: FutureBuilder<List<Widget>>(
        //   future: getScreenList(accessCode),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        //     List<Widget> children;
        //     if (snapshot.hasData) {
        //       children = const <Widget>[
        //         Padding(
        //           padding: EdgeInsets.only(top: 16),
        //           child: Text('HAS DATA')
        //         ),
        //       ];
              
        //     } else if (snapshot.hasError) {
        //       children = const <Widget>[
        //         Padding(
        //           padding: EdgeInsets.only(top: 16),
        //           child: Text('ERROR'),
        //         ),
        //       ];
        //     } else {
        //       children = const <Widget>[
        //         SizedBox(
        //           width: 60,
        //           height: 60,
        //           child: CircularProgressIndicator(),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.only(top: 16),
        //           child: Text('Awaiting result...'),
        //         ),
        //       ];
        //     }
        //   },
        // ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Email',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
