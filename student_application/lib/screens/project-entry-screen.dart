import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:student_application/models/student.dart';

// Create a Form widget.
class ProjectEntryScreen extends StatefulWidget {
  static const routeName = '/entry';
  List<Student> studentList;

  ProjectEntryScreen({required this.studentList});

  @override
  ProjectEntryScreenState createState() {
    return ProjectEntryScreenState();
  }
}

class ProjectEntryScreenState extends State<ProjectEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  String _IDUsers = '';
  String _latitude = '';
  String _longitude = '';

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save(); // Save form
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
                      leading: Text(
                        'What did you find?',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                            _IDUsers = value.toString();
                         });
                        },
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

                              if (-90 <= double.parse(value) &&
                                  double.parse(value) <= 90) {
                                return 'Enter value between -90 and 90.';
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
                          width: 20,
                          height: 20,
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

                              if (-180 <= double.parse(value) &&
                                  double.parse(value) <= 180) {
                                return 'Enter value between -90 and 90.';
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
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              color: Colors.white,
                              size: 150,
                            ),
                            ElevatedButton(
                              child: Text("Upload Image"),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: _onSubmit, child: Text('Submit'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
