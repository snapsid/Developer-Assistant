import 'package:flutter/material.dart';

class MyLinux extends StatefulWidget {
  @override
  _MyLinuxState createState() => _MyLinuxState();
}

class _MyLinuxState extends State<MyLinux> {
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
                margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter your IP",
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
                        onPressed: () {},
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
