import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyAwsHome extends StatefulWidget {
  @override
  _MyAwsHomeState createState() => _MyAwsHomeState();
}

class _MyAwsHomeState extends State<MyAwsHome> {
  bool loading = false;
  String ip;
  final List<String> titles = [
    "S3",
    "EBS\nVolume",
    "Security\nGroup",
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
        'assets/aws.png',
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
        'assets/aws.png',
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
        'assets/aws.png',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AWS'),
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
                          Navigator.pushNamed(context, 's3home');
                        } else if (index == 1) {
                          Navigator.pushNamed(context, 'ebshome');
                        } else if (index == 2) {
                          Navigator.pushNamed(context, 'pullimage');
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
