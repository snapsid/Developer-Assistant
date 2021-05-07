import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class S3allbuckets extends StatefulWidget {
  @override
  _S3allbucketsState createState() => _S3allbucketsState();
}

class _S3allbucketsState extends State<S3allbuckets> {
  bool loading = false;

  String ip;
  String bucketString = "";
  var bucketList = [];
  var totalitems = 0;

  void initState() {
    ip = MyIp.ip_public;
    // TODO: implement initState
    super.initState();
    getBuckets();
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

  parseData() {
    bucketList = bucketString.split("\n");
    print(bucketList);

    if (bucketList.length > 0) {
      setState(() {
        totalitems = bucketList.length - 1;
      });
    }

    print(totalitems);
  }

  getBuckets() async {
    myToast('Please Wait...', Colors.blue);
    setState(() {
      loading = true;
    });
    var url =
        Uri.parse('http://${ip}/cgi-bin/aws/awsservices/s3/listbuckets.py');
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
          bucketString = body;
        });

        parseData();
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
    print("slllllllll ${bucketList[index]}");

    var items = bucketList[index].toString().split(" ");

    var date = items[0];
    print(date);
    var time = items[1];
    print(time);
    var name = items[2];
    print(name);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          color: Colors.white,
          child: Container(
            height: 120,
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
                          "Name: $name",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 23,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Date: $date',
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
                          'Created time: $time',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )),
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
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                // deleteVolume(volumeId);
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
        title: Text('All buckets'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // print(getJson);
                getBuckets();
              }),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(context, 's3createvolume');
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
            itemCount: totalitems,
            itemBuilder: (BuildContext context, int index) {
              if (totalitems != 0) {
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
