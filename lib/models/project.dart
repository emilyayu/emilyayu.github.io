import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Project {
  int IDProjects;
  String ProjectName = '';
  String ProjectType = '';
  String ProjectDescription = '';
  String ProjectImage = '';
  int AccessCode;
  String ProjectInstructions = '';

  Project(
      {required this.IDProjects,
      required this.ProjectName,
      required this.ProjectType,
      required this.ProjectDescription,
      required this.ProjectImage,
      required this.AccessCode,
      required this.ProjectInstructions});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
      IDProjects: json["IDProjects"],
      ProjectName: json["ProjectName"],
      ProjectType: json["ProjectType"],
      ProjectDescription: json["ProjectDescription"],
      ProjectImage: json["ProjectImage"],
      AccessCode: json["AccessCode"],
      ProjectInstructions: json["ProjectInstructions"]);
}

Project testProject = Project(
    IDProjects: 12,
    ProjectName: 'Test Project',
    ProjectType: 'Test Type',
    ProjectDescription: 'Description',
    ProjectImage: 'testImage.com',
    AccessCode: 1234,
    ProjectInstructions: 'Test instructions');
