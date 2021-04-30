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
                        controller: textController,
                        onChanged: (value) {
                          inputCmd = value;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "What would you like to do?",
                            border: OutlineInputBorder(
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
