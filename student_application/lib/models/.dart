import 'package:flutter/material.dart';

class Student {
  int IDUser;
  String FirstName = '';
  String LastName = '';

  Student({
    required this.IDUser, 
    required this.FirstName, 
    required this.LastName
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      IDUser: json["IDUser"],
      FirstName: json["FirstName"],
      LastName: json["LastName"]
  );
  
}
