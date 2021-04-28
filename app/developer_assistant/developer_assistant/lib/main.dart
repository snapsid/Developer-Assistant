import 'package:developer_assistant/ip.dart';
import 'package:developer_assistant/myhome.dart';
import 'package:developer_assistant/python.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'python',
    routes: {
      'ip': (context) => MyIp(),
      'home': (context) => MyHome(),
      'python': (context) => MyPython(),
    },
  ));
}
