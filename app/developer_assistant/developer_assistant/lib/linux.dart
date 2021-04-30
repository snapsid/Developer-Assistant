import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyLinux extends StatefulWidget {
  @override
  _MyLinuxState createState() => _MyLinuxState();
}

class _MyLinuxState extends State<MyLinux> {
  var inputCmd = "aa";

  var textController = TextEditingController();

  onSend() async {
    print(inputCmd);

    var url =
        Uri.parse('http://192.168.1.12/cgi-bin/linux/linux.py?x=$inputCmd');
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

    inputCmd = '';
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Linux'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: ListView(
                  children: [
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, left: 40),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10, right: 40),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(
                        'Hello, World!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextField(
                        cursorColor: Colors.teal,
                        controller: textController,
                        onChanged: (value) {
                          inputCmd = value;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.teal.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            filled: true,
                            hintText: "What would you like to do?",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      minRadius: 25,
                      backgroundColor: Colors.teal,
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          onSend();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
