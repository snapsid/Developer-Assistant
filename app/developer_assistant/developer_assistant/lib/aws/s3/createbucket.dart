import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

class MyS3CreateBucket extends StatefulWidget {
  @override
  _MyS3CreateBucketState createState() => _MyS3CreateBucketState();
}

class _MyS3CreateBucketState extends State<MyS3CreateBucket> {
  bool loading = false;
  var name = "";
  var region = "";
  String ip;

  @override
  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();
  }

  createVolume() async {
    myToast('Creating Volume\nPlease Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse(
        'http://${ip}/cgi-bin/aws/awsservices/s3/createbucket.py?x=$name&y=$region');
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
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        print('invalid IP');
        myToast('Invalid IP', Colors.red.shade300);
        setState(() {
          loading = false;
        });
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    } catch (e) {
      print(e);
      myToast('Server connection failed...', Colors.red.shade300);
      setState(() {
        loading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }
  }

  onTextCheck() {
    if (name == "") {
      myToast('Enter name', Colors.red);
    } else if (region == "") {
      myToast('Enter region', Colors.red);
    } else {
      createVolume();
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S3 create bucket'),
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
                    name = value;
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
                      hintText: "Enter unique bucket name",
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
                    region = value;
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
                      hintText: "Enter region",
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
                      'Create Bucket',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      onTextCheck();
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
