import 'package:flutter/material.dart';

class MyDockerImage extends StatefulWidget {
  @override
  _MyDockerImageState createState() => _MyDockerImageState();
}

class _MyDockerImageState extends State<MyDockerImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docker my images'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
