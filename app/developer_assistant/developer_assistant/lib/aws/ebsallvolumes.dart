import 'dart:convert';

import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

class EbsAllVolumes extends StatefulWidget {
  @override
  _EbsAllVolumesState createState() => _EbsAllVolumesState();
}

class _EbsAllVolumesState extends State<EbsAllVolumes> {
  bool loading = false;
  var getJson = "";

  String ip;

  var state = "";
  var size;
  var zone = "";
  var volumeId = "";
  var volumeType = "";
  var listLength = 0;

  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();

    getVolumes();
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

  parseVolumeJson(index) {
    var x = jsonDecode(getJson);
    List x1 = x['Volumes'];

    var numOfVolumes = x1.length;

    state = x1[index]['State'];
    size = x1[index]['Size'];
    zone = x1[index]['AvailabilityZone'];
    volumeId = x1[index]['VolumeId'];
    volumeType = x1[index]['VolumeType'];
    listLength = numOfVolumes;

    print("lisss $listLength");
  }

  getVolumes() async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url =
        Uri.parse('http://${ip}/cgi-bin/aws/awsservices/ebs/listvolumes.py');
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

        myToast("success", Colors.teal);

        setState(() {
          getJson = body;
          loading = false;
          var x = jsonDecode(getJson);
          print("xxxxx $x");
          List x1 = x['Volumes'];
          listLength = x1.length;
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

  deleteVolume(volumeid) async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url = Uri.parse(
        'http://${ip}/cgi-bin/aws/awsservices/ebs/deletevolume.py?x=$volumeid');
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
          getVolumes();
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
    var x = jsonDecode(getJson);
    print("xxxxx $x");
    List x1 = x['Volumes'];

    // var numOfVolumes = x1.length;

    state = x1[index]['State'];
    size = x1[index]['Size'];
    zone = x1[index]['AvailabilityZone'];
    volumeId = x1[index]['VolumeId'];
    volumeType = x1[index]['VolumeType'];
    // listLength = numOfVolumes;

    print("lisss $listLength");

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
                          "ID: $volumeId",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 23,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Size: $size',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Text(
                          'Type: $volumeType',
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
                          'Availability Zone: $zone',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 30, right: 20),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'State: $state',
                          style: TextStyle(
                              color: Colors.teal.shade500,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
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
                Icons.sd_storage,
                color: Colors.white,
              ),
              Text(
                "size",
                style: TextStyle(color: Colors.white, fontSize: 18),
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
                deleteVolume(volumeId);
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
        title: Text('All volumes'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // print(getJson);
                getVolumes();
              }),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(context, 'ebscreatevolume');
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
              if (listLength != 0) {
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
