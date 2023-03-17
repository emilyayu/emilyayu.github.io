import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import './exceptions.dart';

import './project.dart';
import './student.dart';

import '../screens/project-screen.dart';
import '../screens/project-entry-screen.dart';

Future<File> getImageFileFromAssets(String path) async {

  // final images = json
  //     .decode(await rootBundle.loadString('AssetManifest.json'))
  //     .keys
  //     // .where((String key) => key.contains('res/assets/icons/'))
  //     .toList();
  // print(images.toString());

  final byteData = await rootBundle.load('assets/images/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');

  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<List<Widget>> getScreenList(accessCode) async {
  List<Widget> widgetOptions = [];
  File defaultImage =
      await getImageFileFromAssets('default_project_image.png');

  try {
    Project project = await getProject(accessCode);
    widgetOptions.add(ProjectScreen(
      project: project,
    ));

    var studentList = await getProjectEntryScreen(project);
    widgetOptions.add(ProjectEntryScreen(
        studentList: studentList, project: project, EntryImage: defaultImage));
  } on AccessCodeException {
    print("access Exception");
    rethrow;
  } on EmptyStudentException {
    print("access Exception");
    rethrow;
  }

  return widgetOptions;
}

Future<Project> getProject(String accessCode) async {
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

  return project;
}

Future<List<Student>> getProjectEntryScreen(Project project) async {
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

  // classList.forEach((element) => print(element.FirstName));
  return classList;
}
