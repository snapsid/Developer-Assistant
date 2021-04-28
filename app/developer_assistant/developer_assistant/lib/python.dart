import 'package:flutter/material.dart';

class MyPython extends StatefulWidget {
  @override
  _MyPythonState createState() => _MyPythonState();
}

class _MyPythonState extends State<MyPython> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Python Terminal'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
