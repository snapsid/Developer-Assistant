import 'package:flutter/material.dart';

class MyLinux extends StatefulWidget {
  @override
  _MyLinuxState createState() => _MyLinuxState();
}

class _MyLinuxState extends State<MyLinux> {
  var inputCmd;

  var textController = TextEditingController();

  onSend() {
    print(inputCmd);
    setState(() {
      inputCmd = '';
      textController.clear();
    });
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
              Expanded(child: Container()),
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
