
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

// Create a corresponding State class.
// This class holds data related to the form.
class ProjectEntryScreenState extends State<ProjectEntryScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<ProjectEntryScreenState>.
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownList = [];
    widget.studentList.forEach(
      (element) => {
        dropdownList.add(
          DropdownMenuItem<String>(child: Text(element.FirstName + ' ' + element.LastName), value: element.IDUser.toString()),
        )
      }
    );
    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: Center(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                        border: OutlineInputBorder()
                      ),
                      items: dropdownList,
                      onChanged: (_){}
                    ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))
                              ],
                            decoration: InputDecoration(
                              labelText: 'Latitude',
                              border: OutlineInputBorder()
                              ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))
                            ],
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                
              ],
            )),
      ),
    );
  }
}