import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './exceptions.dart';

import './project.dart';
import './student.dart';

import '../screens/project-screen.dart';
import '../screens/project-entry-screen.dart';

Future<List<Widget>> getScreenList(accessCode) async {
  List<Widget> widgetOptions = [];

  try {
    Widget projectScreen = await getProjectScreen(accessCode);
    widgetOptions.add(projectScreen);

    Widget projectEntryScreen = await getProjectEntryScreen();
    widgetOptions.add(projectEntryScreen);
  } on AccessCodeException {
    rethrow;
  } on EmptyStudentException {
    rethrow;
  }

  return widgetOptions;
}

Future<Widget> getProjectScreen(String accessCode) async {
  final url = Uri.https('helpful-compass-376223.uw.r.appspot.com',
      'projects/accesscode/' + accessCode);

  final response = await http.get(url);
  // print(response.body);
  Iterable projectList = jsonDecode(response.body);
  // print(projectList);
  if (projectList.isEmpty) {
    throw AccessCodeException('Invalid Access Code');
  }
  var projectData = projectList.elementAt(0);
  // print(projectData);
  Project project = Project.fromJson(projectData);

  // print(project.ProjectName);

  return ProjectScreen(project: project);
}

Future<Widget> getProjectEntryScreen() async {
  final url = Uri.https(
      'helpful-compass-376223.uw.r.appspot.com', '/users/json-students');

  final response = await http.get(url);
  // print(response.body);
  Iterable studentList = jsonDecode(response.body);
  // print(projectList);
  if (studentList.isEmpty) {
    throw EmptyStudentException('No Students Enrolled');
  }

  List<Student> classList = [];
  studentList.forEach((element) => classList.add(Student.fromJson(element)));

  return ProjectEntryScreen(studentList: classList);
}

