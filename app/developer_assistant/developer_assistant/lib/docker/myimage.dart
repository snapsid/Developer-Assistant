import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyDockerImage extends StatefulWidget {
  @override
  _MyDockerImageState createState() => _MyDockerImageState();
}

class _MyDockerImageState extends State<MyDockerImage> {
  bool loading = false;

  String ip;
  var imageList = [];
  var finalList = [];

  @override
  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();
    getImages();
  }

  imageStringSplit() {
    {
      print(imageList);

      for (int i = 0; i < imageList.length - 1; i++) {
        var i1 = imageList[i].toString().substring(0, 13);
        var i2 = imageList[i].toString().substring(13, 23);
        var i3 = imageList[i].toString().substring(23, 38);
        var i4 = imageList[i].toString().substring(38, 53);
        var i5 = imageList[i].toString().substring(53);

        String a =
            "${i1.trimRight()} ${i2.trimRight()} ${i3.trimRight()} ${i4.trimRight()} ${i5.trimRight()}";
        finalList.add(a);
      }

      print(finalList);
      myToast(finalList[1], Colors.teal);

      // print(imageList[1]);
      // var i2 = imageList[1].toString().substring(13, 23);
      // print(i2);

      //  0, 7, 11,  14+15+16, 21
      //  (0,13), (13,23),(23, 38),(38, 53)
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

  getImages() async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse('http://${ip}/cgi-bin/docker/docker/myimage.py');
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
        myToast(body, Colors.teal);
        setState(() {
          loading = false;
        });
        imageList = body.split('\n');
        imageStringSplit();
      } else {
        print('invalid IP');
        myToast('Invalid IP', Colors.red);
        setState(() {
          loading = false;
        });
        // Navigator.pushNamedAndRemoveUntil(
        //     context, 'dockerhome', (route) => false);
      }
    } catch (e) {
      print(e);
      myToast('Server connection failed...', Colors.red);
      setState(() {
        loading = false;
      });
      // Navigator.pushNamedAndRemoveUntil(
      //     context, 'dockerhome', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docker my images'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                imageStringSplit();

                // print(imageList[1]);
                // var i2 = imageList[1].toString().substring(13, 23);
                // print(i2);

                //  0, 7, 11,  14+15+16, 21
                //  (0,13), (13,23),(23, 38),(38, 53)
              })
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: CircularProgressIndicator(
          // backgroundColor: Colors.teal,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          strokeWidth: 6,
        ),
        child: Container(),
      ),
    );
  }
}
