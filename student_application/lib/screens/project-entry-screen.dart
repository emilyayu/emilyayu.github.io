import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'package:student_application/models/project.dart';
import 'package:student_application/models/student.dart';
import 'package:student_application/models/project-entry.dart';

// Source: generate file from image asset
// URL: https://stackoverflow.com/questions/55295593/how-to-convert-asset-image-to-file

// Create a Form widget.
class ProjectEntryScreen extends StatefulWidget {
  static const routeName = '/entry';
  File EntryImage;
  Project project;
  List<Student> studentList;

  ProjectEntryScreen(
      {required this.studentList,
      required this.project,
      required this.EntryImage});

  @override
  ProjectEntryScreenState createState() {
    return ProjectEntryScreenState();
  }
}

class ProjectEntryScreenState extends State<ProjectEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  // File? EntryImage;
  String _UsersFK = '';
  String _latitude = '';
  String _longitude = '';

  Future pickImage() async {
    try {
      final EntryImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (EntryImage == null) {
        print('IMAGE ERROR');
        return;
      }

      final EntryImageTemp = File(EntryImage.path);

      setState(() {
        widget.EntryImage = EntryImageTemp;
      });
    } on PlatformException {
      print("Try Again");
    }
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save(); // Save form

      // create entry with data
      ProjectEntry projectEntry = ProjectEntry(
          EntryImage: widget.EntryImage,
          Latitude: _latitude,
          Longitude: _latitude,
          ProjectsFK: widget.project.IDProjects.toString(),
          UsersFK: _UsersFK);

      //post entry
      try {
        await postProjectEntry(projectEntry);
        print('Post Successful');
      } catch (e) {
        print('Post Error');
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownList = [];
    widget.studentList.forEach((element) => {
          dropdownList.add(
            DropdownMenuItem<String>(
                child: Text(element.FirstName + ' ' + element.LastName),
                value: element.IDUser.toString()),
          )
        });
    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: Center(
        child: Card(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text(widget.project.ProjectName,
                          style: Theme.of(context).textTheme.displaySmall),
                      subtitle: Text(
                        'What did you find?',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'Select a Student',
                          border: OutlineInputBorder()),
                      items: dropdownList,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select a student.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _UsersFK = value.toString();
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    AspectRatio(
                        aspectRatio: 1, child: Image.file(widget.EntryImage)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                          child: Row(
                            children: [
                              Text('Upload Image '),
                              Icon(Icons.add_a_photo),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.-]'))
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter latitude.';
                              }
                              if (double.parse(value) < -90 ||
                                  double.parse(value) > 90) {
                                return 'Between [-90, 90]';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _latitude = value.toString();
                              });
                            },
                            decoration: InputDecoration(
                                labelText: 'Latitude',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.-]'))
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter longitude.';
                              }

                              if (double.parse(value) < -180 ||
                                  double.parse(value) > 180) {
                                return 'Between [-180, 180]';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _longitude = value.toString();
                              });
                            },
                            decoration: InputDecoration(
                                labelText: 'Longitude',
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: _onSubmit, child: Text('Submit Data'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
