import 'package:developer_assistant/aws/awshome.dart';
import 'package:developer_assistant/aws/ebshome.dart';
import 'package:developer_assistant/c_code.dart';
import 'package:developer_assistant/c_output.dart';
import 'package:developer_assistant/cplusplus.dart';
import 'package:developer_assistant/cpp_output.dart';
import 'package:developer_assistant/docker/allcontainers.dart';
import 'package:developer_assistant/docker/dockerhome.dart';
import 'package:developer_assistant/docker/myimage.dart';
import 'package:developer_assistant/docker/myrunningcontainer.dart';
import 'package:developer_assistant/docker/pullimage.dart';
import 'package:developer_assistant/docker/runcontainer.dart';
import 'package:developer_assistant/docker/service.dart';
import 'package:developer_assistant/ip.dart';
import 'package:developer_assistant/linux.dart';
import 'package:developer_assistant/myhome.dart';
import 'package:developer_assistant/python.dart';
import 'package:developer_assistant/python_output.dart';
import 'package:developer_assistant/software.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'ip': (context) => MyIp(),
      'home': (context) => MyHome(),
      'python': (context) => MyPython(),
      'python_output': (context) => MyPythonOutput(),
      'ccode': (context) => MyC_code(),
      'c_output': (context) => MyC_output(),
      'cppcode': (context) => MyCplusplus(),
      'cpp_output': (context) => Mycpp_output(),
      'linux': (context) => MyLinux(),
      'software': (context) => MySoftware(),
      'dockerhome': (context) => DockerHome(),
      'dockerservice': (context) => MyDockerService(),
      'pullimage': (context) => DockerPullUmage(),
      'runcontainer': (context) => DockerRunContainer(),
      'dockermyimages': (context) => MyDockerImage(),
      'myrunningcontainer': (context) => MyRunningContainer(),
      'dockerallcontainers': (context) => DockerAllContainers(),
      'awshome': (context) => MyAwsHome(),
      'ebshome': (context) => EbsHome(),
    },
  ));
}
