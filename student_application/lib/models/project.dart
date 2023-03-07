import 'package:flutter/material.dart';

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
      required this.ProjectInstructions
      });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
      IDProjects: json["IDUser"],
      ProjectName: json["ProjectName"],
      ProjectType: json["ProjectType"],
      ProjectDescription: json["ProjectDescription"],
      ProjectImage: json["ProjectImage"],
      AccessCode: json["AccessCode"],
      ProjectInstructions: json["ProjectInstructions"]
  );
}
