import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ip.dart';

class MyLinux extends StatefulWidget {
  @override
  _MyLinuxState createState() => _MyLinuxState();
}

class _MyLinuxState extends State<MyLinux> {
  var inputCmd = "aa";
  var scrollcontorller = ScrollController();
  String ip;

  List msg = [
    "qwe",
    "abcd",
    "xyz",
    "zxc",
  ];

  var textController = TextEditingController();

  onSend() async {
    ip = MyIp.ip_public;
    print(inputCmd);

    setState(() {
      msg.add(inputCmd);
      scrollcontorller.animateTo(scrollcontorller.position.maxScrollExtent,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
    textController.clear();

    var url = Uri.parse('http://${ip}/cgi-bin/linux/linux.py?x=$inputCmd');
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

        setState(() {
          msg.add(body);
        });
      } else {
        print('invalid IP');
      }
    } catch (e) {
      print(e);
    }

    inputCmd = '';
  }

  @override
  Widget build(BuildContext context) {
    var chatAlignment = Alignment.topRight;
    var chatnip = BubbleNip.rightTop;
    var bubbleMargin = BubbleEdges.only(top: 10, left: 40);
    var chatColor = Color.fromRGBO(225, 255, 199, 1.0);
    var chatMsgAlgn = TextAlign.right;

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
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollcontorller,

                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: msg.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index % 2 == 0) {
                      chatAlignment = Alignment.topRight;
                      chatnip = BubbleNip.rightTop;
                      bubbleMargin = BubbleEdges.only(top: 10, left: 40);
                      chatColor = Color.fromRGBO(225, 255, 199, 1.0);
                      chatMsgAlgn = TextAlign.right;
                    } else {
                      chatAlignment = Alignment.topLeft;
                      chatnip = BubbleNip.leftTop;
                      bubbleMargin = BubbleEdges.only(top: 10, right: 40);
                      chatColor = Colors.white70;
                      chatMsgAlgn = TextAlign.left;
                    }
                    return Bubble(
                      margin: bubbleMargin,
                      alignment: chatAlignment,
                      nip: chatnip,
                      // color: Color.fromRGBO(225, 255, 199, 1.0),
                      color: chatColor,
                      child: Text(
                        '${msg[index]}',
                        style: TextStyle(fontSize: 18),
                        textAlign: chatMsgAlgn,
                      ),
                    );
                  },
                  // children: [
                  //   Bubble(
                  //     margin: BubbleEdges.only(top: 10, left: 40),
                  //     alignment: Alignment.topRight,
                  //     nip: BubbleNip.rightTop,
                  //     color: Color.fromRGBO(225, 255, 199, 1.0),
                  //     child: Text(
                  //       'Hello, World!',
                  //       style: TextStyle(fontSize: 18),
                  //       textAlign: TextAlign.right,
                  //     ),
                  //   ),
                  //   Bubble(
                  //     margin: BubbleEdges.only(top: 10, right: 40),
                  //     alignment: Alignment.topLeft,
                  //     nip: BubbleNip.leftTop,
                  //     child: Text(
                  //       'Hello, World!',
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   ),
                  // ],
                ),
              )),
              Container(
                margin:
                    EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 4),
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
