import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Student {
  int IDUser;
  String FirstName = '';
  String LastName = '';
  String Email = '';
  int IsTeacher;

  Student({
    required this.IDUser, 
    required this.FirstName, 
    required this.LastName,
    required this.Email,
    required this.IsTeacher
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      IDUser: json["IDUser"],
      FirstName: json["FirstName"],
      LastName: json["LastName"],
      Email: json["Email"],
      IsTeacher: json["IsTeacher"]
  );
  
}
