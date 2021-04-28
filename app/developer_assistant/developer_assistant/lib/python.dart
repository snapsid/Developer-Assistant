import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPython extends StatefulWidget {
  @override
  _MyPythonState createState() => _MyPythonState();
}

class _MyPythonState extends State<MyPython> {
  String ip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Python Terminal'),
        backgroundColor: Colors.teal,
      ),
      body: ElevatedButton(
        onPressed: () async {
          ip = MyIp.ip_public;
          var url = Uri.parse('http://${ip}/cgi-bin/python/terminal.py');
          try {
            var response = await http.get(url, headers: {
              "Accept": "application/json",
              "Access-Control_Allow_Origin": "*"
            });
            var code = response.statusCode;
            print(code);
            if (code == 200) {
              var body = response.body;
              print(body);
            } else {
              print('invalid IP');
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
