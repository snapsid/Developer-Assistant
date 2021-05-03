import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  slidelist(index) {
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
                          "os name",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'ID: 799416853',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Text(
                          'Image: centos:5',
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
                          'Created: dateee',
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
                              'Up 16 minutes',
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
                "/bin/bash",
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
            itemCount: 5,
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
