import 'package:flutter/material.dart';
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
  ];

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
    var url = Uri.parse('http://192.168.43.38/cgi-bin/yumconfigure/yum.py');
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
