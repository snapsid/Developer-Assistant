import 'package:flutter/material.dart';

class DockerRunContainer extends StatefulWidget {
  @override
  _DockerRunContainerState createState() => _DockerRunContainerState();
}

class _DockerRunContainerState extends State<DockerRunContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docker launch container'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
