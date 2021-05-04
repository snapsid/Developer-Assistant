import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

class EbsCreateVolume extends StatefulWidget {
  @override
  _EbsCreateVolumeState createState() => _EbsCreateVolumeState();
}

class _EbsCreateVolumeState extends State<EbsCreateVolume> {
  bool loading = false;
  var zone = "";
  var size = "";
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

  createVolume() async {
    myToast('Creating Volume\nPlease Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse(
        'http://${ip}/cgi-bin/aws/awsservices/ebs/ebscreatevolume.py?x=$zone&y=$size');
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
        Navigator.pushNamedAndRemoveUntil(context, 'ebshome', (route) => false);
      } else {
        print('invalid IP');
        myToast('Invalid IP', Colors.red.shade300);
        setState(() {
          loading = false;
        });
        Navigator.pushNamedAndRemoveUntil(context, 'ebshome', (route) => false);
      }
    } catch (e) {
      print(e);
      myToast('Server connection failed...', Colors.red.shade300);
      setState(() {
        loading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, 'ebshome', (route) => false);
    }
  }

  onTextCheck() {
    if (zone == "") {
      myToast('Enter availability', Colors.red);
    } else if (size == "") {
      myToast('Enter size', Colors.red);
    } else {
      createVolume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create EBS volume'),
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
                    zone = value;
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
                      hintText: "Availability Zone (eg: ap-south-1a)",
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
                    size = value;
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
                      hintText: "Enter volume size (in GB)",
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
                      'Create Volume',
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
