import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../ip.dart';

class MyDockerService extends StatefulWidget {
  @override
  _MyDockerServiceState createState() => _MyDockerServiceState();
}

class _MyDockerServiceState extends State<MyDockerService> {
  bool loading = false;
  String ip;
  final List<String> titles = [
    "Service\nStatus",
    "Start/Restart\nService",
    "Stop\nService",
  ];

  @override
  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();
  }

  final List<Widget> images = [
    Card(
      color: Colors.blue,
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.green,
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.red,
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  ];

  myToast(mymsg, color) {
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        webPosition: "center",
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docker Service'),
        backgroundColor: Colors.teal,
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: CircularProgressIndicator(
          // backgroundColor: Colors.teal,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          strokeWidth: 6,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: VerticalCardPager(
                      titles: titles, // required
                      images: images, // required
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold), // optional
                      onPageChanged: (page) {
                        // optional
                      },
                      onSelectedItem: (index) {
                        print(index);
                        if (index == 0) {
                        } else if (index == 1) {
                        } else if (index == 2) {}
                        // optional
                      },
                      initialPage: 0, // optional
                      align: ALIGN.CENTER // optional
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
