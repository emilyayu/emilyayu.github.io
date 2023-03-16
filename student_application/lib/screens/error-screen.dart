import 'package:flutter/material.dart';


class ErrorScreen extends StatelessWidget {
   static const routeName = '/error';
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Flexible(child: Text('Oops something went wrong!')),
      Flexible(
          child: ElevatedButton(
        child: Text('Try Again'),
        onPressed: () => Navigator.pushNamed(context, '/access'),
      ))
    ]));
  }
}
