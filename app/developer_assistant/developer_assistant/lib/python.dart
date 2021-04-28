import 'package:code_text_field/code_text_field.dart';
import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class MyPython extends StatefulWidget {
  @override
  _MyPythonState createState() => _MyPythonState();
}

class _MyPythonState extends State<MyPython> {
  String ip;
  var cmd;
  var _codeController;
  @override
  Widget build(BuildContext context) {
    // final source = "void main() {\n    print(\"Hello, world!\");\n}";
    var source = "print('hello world')";
    _codeController = CodeController(
      text: source,
      language: python,
      theme: atomOneDarkTheme,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Python Terminal'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              icon: Icon(Icons.code),
              onPressed: () {
                print(source);
                var f = _codeController.text;
                print(f);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: CodeField(
                  controller: _codeController,
                  textStyle: TextStyle(fontFamily: 'SourceCode'),
                ),
              ),
              TextField(
                onChanged: (value) {
                  cmd = value;
                },
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter your code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(cmd);
                  ip = MyIp.ip_public;
                  // var url = Uri.parse('http://${ip}/cgi-bin/python/terminal.py');
                  var url = Uri.parse(
                      'http://192.168.1.12/cgi-bin/python/test.py?x=$cmd');
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
            ],
          ),
        ),
      ),
    );
  }
}
