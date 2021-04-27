import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'ip',
    routes: {
      'ip': (context) => MyIp(),
    },
  ));
}
