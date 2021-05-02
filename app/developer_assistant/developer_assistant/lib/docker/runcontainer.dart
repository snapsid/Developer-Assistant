import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

class DockerRunContainer extends StatefulWidget {
  @override
  _DockerRunContainerState createState() => _DockerRunContainerState();
}

class _DockerRunContainerState extends State<DockerRunContainer> {
  bool loading = false;
  var osname = "";
  var image = "";
  var version = "";
  String ip;

  @override
  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();
  }

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

  onStringCheck() {
    if (osname == "") {
      myToast("Enter Container name", Colors.red);
    } else if (image == "") {
      myToast("Enter Image name", Colors.red);
    } else {
      if (version == "") {
        version = 'latest';
      }
      print(osname);
      print(image);
      print(version);
      launchContainer();
    }
  }

  launchContainer() async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse(
        'http://${ip}/cgi-bin/docker/docker/runcontainer.py?x=$osname&y=$image&z=$version');
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
        Navigator.pushNamedAndRemoveUntil(
            context, 'dockerhome', (route) => false);
      } else {
        print('invalid IP');
        myToast('Invalid IP', Colors.red.shade300);
        setState(() {
          loading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, 'dockerhome', (route) => false);
      }
    } catch (e) {
      print(e);
      myToast('Server connection failed...', Colors.red.shade300);
      setState(() {
        loading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, 'dockerhome', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docker launch container'),
        backgroundColor: Colors.teal,
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: CircularProgressIndicator(
          // backgroundColor: Colors.teal,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          strokeWidth: 6,
        ),
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  cursorColor: Colors.teal,
                  onChanged: (value) {
                    osname = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.teal.shade600),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      hintText: "Give Container Name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  cursorColor: Colors.teal,
                  onChanged: (value) {
                    image = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.teal.shade600),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      hintText: "Enter Image Name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  cursorColor: Colors.teal,
                  onChanged: (value) {
                    version = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.teal.shade600),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      hintText: "Enter Version (Default: latest)",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal,
                  elevation: 5,
                  child: MaterialButton(
                    child: Text(
                      'Launch Container',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      onStringCheck();
                    },
                    minWidth: 130,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
