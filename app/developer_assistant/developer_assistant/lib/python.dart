import 'package:code_text_field/code_text_field.dart';
import 'package:developer_assistant/ip.dart';
import 'package:flutter/cupertino.dart';
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

  var _codeController;
  @override
  Widget build(BuildContext context) {
    // final source = "void main() {\n    print(\"Hello, world!\");\n}";
    var source = "print('hello world')";
    var finalCode = "heyyy";
    _codeController = CodeController(
      text: source,
      language: python,
      theme: atomOneDarkTheme,
    );

    onrun() async {
      var cmd = _codeController.text;
      print(cmd);
      ip = MyIp.ip_public;
      // var url = Uri.parse('http://${ip}/cgi-bin/python/terminal.py');
      var url = Uri.parse('http://192.168.1.12/cgi-bin/python/test.py?x=$cmd');
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
    }

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          onrun();
        },
        child: Icon(Icons.play_arrow),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // alignment: Alignment.center,
                // height: MediaQuery.of(context).size.height * 0.8,

                child: CodeField(
                  controller: _codeController,
                  textStyle: TextStyle(fontFamily: 'SourceCode'),
                ),
              ),
              // Container(
              //   child: CircleAvatar(
              //     minRadius: 30,
              //     backgroundColor: Colors.teal,
              //     child: IconButton(
              //       splashColor: Colors.teal,
              //       focusColor: Colors.orange,
              //       highlightColor: Colors.blue,
              //       color: Colors.white,
              //       icon: Icon(Icons.play_arrow),
              //       onPressed: () async {
              //         print(cmd);
              //         ip = MyIp.ip_public;
              //         // var url = Uri.parse('http://${ip}/cgi-bin/python/terminal.py');
              //         var url = Uri.parse(
              //             'http://192.168.1.12/cgi-bin/python/test.py?x=$cmd');
              //         try {
              //           var response = await http.get(url, headers: {
              //             "Accept": "application/json",
              //             "Access-Control_Allow_Origin": "*"
              //           });
              //           var code = response.statusCode;
              //           print(code);
              //           if (code == 200) {
              //             var body = response.body;
              //             print(body);
              //           } else {
              //             print('invalid IP');
              //           }
              //         } catch (e) {
              //           print(e);
              //         }
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
