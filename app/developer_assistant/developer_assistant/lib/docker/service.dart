import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../ip.dart';
import 'package:http/http.dart' as http;

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
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/service_status.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.green,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/start_service.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.red,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/stop_service.png',
        fit: BoxFit.cover,
      ),
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

  onClickServices(par) async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse('http://${ip}/cgi-bin/docker/docker/service.py?x=$par');
    try {
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });
      var code = response.statusCode;
      print(code);
      if (code == 200) {
        var body = await response.body;
        print(body);
        myToast(body, Colors.teal.shade300);
        setState(() {
          loading = false;
        });
        // Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        print('invalid IP');
        myToast('Invalid IP', Colors.red.shade300);
        setState(() {
          loading = false;
        });
        // Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    } catch (e) {
      print(e);
      myToast('Server connection failed...', Colors.red.shade300);
      setState(() {
        loading = false;
      });
      // Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }
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
                          letterSpacing: 5,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 12.0,
                              color: Colors.black54,
                            ),
                          ],
                          fontFamily: 'Chewy',
                          color: Colors.white,
                          fontWeight: FontWeight.bold), // optional
                      onPageChanged: (page) {
                        // optional
                      },
                      onSelectedItem: (index) {
                        print(index);
                        if (index == 0) {
                          onClickServices('status');
                        } else if (index == 1) {
                          onClickServices('restart');
                        } else if (index == 2) {
                          onClickServices('stop');
                        }
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
