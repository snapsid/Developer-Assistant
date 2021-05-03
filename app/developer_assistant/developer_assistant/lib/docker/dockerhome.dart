import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:http/http.dart' as http;

import '../ip.dart';

class DockerHome extends StatefulWidget {
  @override
  _DockerHomeState createState() => _DockerHomeState();
}

class _DockerHomeState extends State<DockerHome> {
  bool loading = false;
  String ip;
  final List<String> titles = [
    "Docker\nService",
    "Launch\nContainer",
    "Pull\nImage",
    "My\nImages",
    "Running\nContainers",
    "All\nContainers",
    "Docker\nVersion",
  ];

  @override
  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();
  }

  final List<Widget> images = [
    Card(
      color: Colors.red,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/docker_service.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.yellow,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/run_container.png',
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
        'assets/pull_image.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.blue,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/my_images.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.orange,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/running_containers.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.grey,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/all_container.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.purple,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/docker_version.png',
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

  dockerVersion() async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse('http://${ip}/cgi-bin/docker/docker/version.py');
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
        title: Text('Docker'),
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
                          print('docker service');
                          Navigator.pushNamed(context, 'dockerservice');
                        } else if (index == 1) {
                          Navigator.pushNamed(context, 'runcontainer');
                        } else if (index == 2) {
                          Navigator.pushNamed(context, 'pullimage');
                        } else if (index == 3) {
                          Navigator.pushNamed(context, 'dockermyimages');
                        } else if (index == 4) {
                          Navigator.pushNamed(context, 'myrunningcontainer');
                        } else if (index == 5) {
                          Navigator.pushNamed(context, 'dockerallcontainers');
                        } else if (index == 6) {
                          print('version');
                          dockerVersion();
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
