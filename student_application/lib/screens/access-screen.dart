import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/futures.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({super.key});
  static const routeName = '/access';

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _accessCode = '';

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save(); // Save form
      Navigator.pushNamed(context, '/tab', arguments: _accessCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citizen Science'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Card(
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 15.0, 0, 0),
                                    child: Text(
                                      'Student Portal',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    'Enter your project code below to start collecting data.',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                  height: 5,
                                ),
                                Flexible(
                                  flex: 4,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter access code.';
                                      }

                                      if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value) ||
                                          value.length != 6) {
                                        return 'Please enter valid access code.';
                                      }

                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _accessCode = value.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Project Code',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                ElevatedButton(
                                    onPressed: _onSubmit, child: Text('Submit'))
                              ],
                            ),
                          )),
                    ),
                    Image.network(
                        'https://storage.googleapis.com/project-image-bucket/Group%201.png',
                        width: 115,
                        height: 115),
                  ],
                ),
              )),
          Flexible(flex: 1, child: Container()),
        ],
      )),
    );
  }
}
