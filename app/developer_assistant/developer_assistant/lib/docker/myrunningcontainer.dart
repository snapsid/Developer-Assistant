import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

class MyRunningContainer extends StatefulWidget {
  @override
  _MyRunningContainerState createState() => _MyRunningContainerState();
}

class _MyRunningContainerState extends State<MyRunningContainer> {
  bool loading = false;

  String ip;
  var imageList = [];
  var finalList = [];
  var listLength = 0;

  @override
  void initState() {
    ip = MyIp.ip_public;
    getRunningContainer();
    // TODO: implement initState
    super.initState();
  }

  imageStringSplit() {
    {
      finalList = [];
      // print(imageList);

      // for (int i = 1; i < imageList.length - 1; i++) {
      //   var i1 = imageList[i].toString().substring(0, 13);
      //   var i2 = imageList[i].toString().substring(13, 23);
      //   var i3 = imageList[i].toString().substring(23, 38);
      //   var i4 = imageList[i].toString().substring(38, 52);
      //   var i5 = imageList[i].toString().substring(52);
      //
      //   String a =
      //       "${i1.trimRight()} ${i2.trimRight()} ${i3.trimRight()} ${i4.trimRight()} ${i5.trimRight()}";
      //   setState(() {
      //     finalList.add(a);
      //   });
      // }

      var idstart = imageList[0].toString().indexOf('CONTAINER ID');
      var imagestart = imageList[0].toString().indexOf('IMAGE');
      var cmdstart = imageList[0].toString().indexOf('COMMAND');
      var createdstart = imageList[0].toString().indexOf('CREATED');
      var statusstart = imageList[0].toString().indexOf('STATUS');
      var portstart = imageList[0].toString().indexOf('PORTS');
      var namesstart = imageList[0].toString().indexOf('NAMES');

      for (int i = 1; i < imageList.length - 1; i++) {
        var i1 = imageList[i].toString().substring(idstart, imagestart);
        var i2 = imageList[i].toString().substring(imagestart, cmdstart);
        var i3 = imageList[i].toString().substring(cmdstart, createdstart);
        var i4 = imageList[i].toString().substring(createdstart, statusstart);
        var i5 = imageList[i].toString().substring(statusstart, portstart);
        var i6 = imageList[i].toString().substring(portstart, namesstart);
        var i7 = imageList[i].toString().substring(namesstart);

        String a =
            "${i1.trimRight()} ${i2.trimRight()} ${i3.trimRight()} ${i4.trimRight()} ${i5.trimRight()} ${i6.trimRight()} ${i7.trimRight()}";

        setState(() {
          finalList.add(a);
        });
      }

      print(finalList);

      // print(finalList);

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

  getRunningContainer() async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url =
        Uri.parse('http://${ip}/cgi-bin/docker/docker/myrunningcontainer.py');
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
          imageList = body.split('\n');
          imageStringSplit();
          loading = false;
          listLength = imageList.length - 2;
        });
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

  slidelist(index) {
    var finalSplitString = finalList[index].toString().split(" ");
    print("fffffffff $finalSplitString");
    var containerId = finalSplitString[0];
    var imageName = finalSplitString[1];
    var shell = finalSplitString[2];
    var osName = finalSplitString[finalSplitString.length - 1];
    var uptime =
        "${finalSplitString[finalSplitString.length - 5]} ${finalSplitString[finalSplitString.length - 4]} ${finalSplitString[finalSplitString.length - 3]}";
    var createdDate = "";

    if (finalSplitString.length == 12) {
      createdDate =
          "${finalSplitString[finalSplitString.length - 9]} ${finalSplitString[finalSplitString.length - 8]} ${finalSplitString[finalSplitString.length - 7]} ${finalSplitString[finalSplitString.length - 6]}";
    }
    if (finalSplitString.length == 11) {
      createdDate =
          "${finalSplitString[finalSplitString.length - 8]} ${finalSplitString[finalSplitString.length - 7]} ${finalSplitString[finalSplitString.length - 6]}";
    }

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          color: Colors.white,
          child: Container(
            height: 150,
            // margin: EdgeInsets.only(top: 10),
            child: Card(
              elevation: 1,
              child: Container(
                margin: EdgeInsets.only(left: 30, top: 10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$osName",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'ID: $containerId',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Text(
                          'Image: $imageName',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 10, right: 20),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Created: $createdDate',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, right: 20),
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$uptime',
                              style: TextStyle(
                                  color: Colors.teal.shade500,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )),
      actions: <Widget>[
        // IconSlideAction(
        //   caption: 'Archive',
        //   color: Colors.blue,
        //   icon: Icons.archive,
        //   onTap: () {},
        // ),
        // IconSlideAction(
        //   caption: 'Share',
        //   color: Colors.indigo,
        //   icon: Icons.share,
        //   onTap: () {},
        // ),
      ],
      secondaryActions: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: double.infinity,
          width: double.infinity,
          color: Colors.black45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.code,
                color: Colors.white,
              ),
              Text(
                shell,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                // removeImage(imageId);
              });
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docker running containers'),
        backgroundColor: Colors.teal,
        actions: [],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(context, 'runcontainer');
        },
        child: Icon(Icons.add),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: CircularProgressIndicator(
          // backgroundColor: Colors.teal,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          strokeWidth: 6,
        ),
        child: Container(
          child: ListView.builder(
            shrinkWrap: true,
            // controller: scrollcontorller,

            padding: EdgeInsets.only(bottom: 20),
            itemCount: listLength,
            itemBuilder: (BuildContext context, int index) {
              if (finalList != 0) {
                return slidelist(index);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
