import 'package:flutter/material.dart';

class MyLinux extends StatefulWidget {
  @override
  _MyLinuxState createState() => _MyLinuxState();
}

class _MyLinuxState extends State<MyLinux> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linux'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
