import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:http/http.dart' as http;

class MySoftware extends StatefulWidget {
  @override
  _MySoftwareState createState() => _MySoftwareState();
}

class _MySoftwareState extends State<MySoftware> {
  final List<String> titles = [
    "INSTALL\nDOCKER",
    "CONFIGURE\nYUM",
    "INSTALL\n AWS CLI"
  ];

  final List<Widget> images = [
    Card(
      color: Colors.red,
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.yellow,
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.blue,
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

  dockerClick() async {
    print('Docker');
    var url = Uri.parse('http://192.168.43.38/cgi-bin/docker/docker.py');
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
      } else {
        print('invalid IP');
      }
    } catch (e) {
      print(e);
    }
  }

  yumClick() async {
    print('yum');
    myToast('Please Wait...', Colors.blue);

    var url = Uri.parse('http://192.168.1.12/cgi-bin/yumconfigure/yum.py');
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
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        print('invalid IP');
        myToast('Invalid IP', Colors.red.shade300);
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
      // Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } catch (e) {
      print(e);
      myToast('Server connection failed...', Colors.red.shade300);
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }
  }

  awsClick() async {
    print('aws');
    var url =
        Uri.parse('http://192.168.43.38/cgi-bin/aws/install/awsinstall.py');
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
      } else {
        print('invalid IP');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installation / Configure'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
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
                        dockerClick();
                      } else if (index == 1) {
                        yumClick();
                      } else if (index == 2) {
                        awsClick();
                      }
                      // optional
                    },
                    initialPage: 0, // optional
                    align: ALIGN.LEFT // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
