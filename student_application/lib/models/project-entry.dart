import 'dart:ffi';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:student_application/models/exceptions.dart';

import 'package:uuid/uuid.dart';

class ProjectEntry {
  File EntryImage;
  String Latitude = '';
  String Longitude = '';
  String ProjectsFK = '';
  String UsersFK = '';

  ProjectEntry(
      {required this.EntryImage,
      required this.Latitude,
      required this.Longitude,
      required this.ProjectsFK,
      required this.UsersFK});

  printEntry() {
    print('Entry Image:' + EntryImage.path);
    print('Latitude:' + Latitude);
    print('Longitude:' + Longitude);
    print('Projects FK:' + ProjectsFK);
    print('Users FK:' + UsersFK);
  }
}

Future<void> postProjectEntry(ProjectEntry entry) async {
  // entry.printEntry();
  var uuid = Uuid();
  String v4 = uuid.v4.hashCode.toString();

  try {
    var uri = Uri.https(
        'helpful-compass-376223.uw.r.appspot.com', '/project-entries/');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromBytes(
          'EntryImage', File(entry.EntryImage.path).readAsBytesSync(),
          filename: 'image_${entry.ProjectsFK}_$v4'))
      ..fields['EntryLatLong'] = 'POINT(${entry.Latitude} ${entry.Longitude})'
      ..fields['ProjectsFK'] = entry.ProjectsFK
      ..fields['UsersFK'] = entry.UsersFK;
    print('request sending ...');
    var response = await request.send();

    switch (response.statusCode) {
      case 302:
        return;
      default:
        throw ProjectEntryException(response.reasonPhrase.toString());
    }
  } on SocketException catch (_) {
    rethrow;
  }
}
