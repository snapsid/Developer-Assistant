import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<String> titles = [
    "AWS",
    "DOCKER",
    "PYTHON",
    "C COMPILER",
    "C++\nCOMPILER",
    "INSTALL/\nCONFIGURE",
    "LINUX",
  ];

  final List<Widget> images = [
    Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // color: Colors.red,
      elevation: 20,
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
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // color: Colors.yellow,
      elevation: 20,
      child: Image.asset(
        'assets/docker.png',
        fit: BoxFit.fitWidth,
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
        'assets/python.png',
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
        'assets/c_compiler.png',
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
        'assets/cpp_compiler.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      // color: Colors.grey,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/installconf.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      // color: Colors.purple,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/linux.png',
        fit: BoxFit.cover,
      ),
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Developer Assistant',
        ),
        backgroundColor: Colors.teal,
        actions: [],
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
                        letterSpacing: 5,
                        fontFamily: 'Chewy',
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 12.0,
                            color: Colors.black54,
                          ),
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.bold), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      print(index);
                      if (index == 0) {
                        Navigator.pushNamed(context, 'awshome');
                      } else if (index == 1) {
                        Navigator.pushNamed(context, 'dockerhome');
                      } else if (index == 2) {
                        Navigator.pushNamed(context, 'python');
                      } else if (index == 3) {
                        Navigator.pushNamed(context, 'ccode');
                      } else if (index == 4) {
                        Navigator.pushNamed(context, 'cppcode');
                      } else if (index == 5) {
                        Navigator.pushNamed(context, 'software');
                      } else if (index == 6) {
                        Navigator.pushNamed(context, 'linux');
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
    );
  }
}
