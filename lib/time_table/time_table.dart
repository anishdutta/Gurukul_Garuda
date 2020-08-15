import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/networking/class_data.dart';
import 'package:educationapp/time_table/classes.dart';
import 'package:educationapp/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildClasses extends StatefulWidget {
  int index;
  BuildClasses({this.index});

  @override
  _BuildClassesState createState() => _BuildClassesState();
}

class _BuildClassesState extends State<BuildClasses> {
  final DateFormat dateFormat = DateFormat("hh:mm a");
  ClassData classData = ClassData();
  String classID;
  List weekDay = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  final firestoreInstance = Firestore.instance;
  void RetrieveClass() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection("Classes")
        .document(firebaseUser.uid)
        .get()
        .then((value) {
      print(value.data["Classes"]);
      classID = value.data["Classes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: classData.getClassData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Text('Time Table',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Merriweather',
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: weekDay.length - 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "${snapshot.data['Items'][widget.index]['Schedule']['M']['$index']['M']['Period']['S']}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).accentColor,
                                  size: 23.0,
                                ),
                                SizedBox(width: 20.0),
                                Text(
                                  "${weekDay[index]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Container(
                                  height: 25.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Now",
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 108.0, bottom: 20.0),
                                  width: 2,
                                  height: 100.0,
                                  color: kTextColor,
                                ),
                                SizedBox(width: 28.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.school,
                                          color: Theme.of(context).accentColor,
                                          size: 20.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Online Class",
                                          style: TextStyle(
                                            color: kTextColor,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          color: Theme.of(context).accentColor,
                                          size: 20.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "${snapshot.data['Items'][index]['Prof']['S']}",
                                          style: TextStyle(
                                            color: kTextColor,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return (Center(
              child: CircularProgressIndicator(),
            ));
          }
        },
      ),
    );
  }

  _getStatus(Classes c) {
    DateTime now = DateTime.now();
    DateTime finishedTime = c.time.add(Duration(hours: 1));

    if (now.difference(c.time).inMinutes >= 59) {
      c.isDone = true;
    } else if (now.difference(c.time).inMinutes <= 59 &&
        now.difference(finishedTime).inMinutes >= -59) {
      c.isDone = true;
    }
  }

  _getTime(Classes c, context) {
    return Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: c.isDone
              ? Theme.of(context).accentColor.withOpacity(0.3)
              : Theme.of(context).accentColor,
          // width: 2.0,
        ),
      ),
      child: _getChild(c, context),
    );
  }

  _getChild(Classes c, context) {
    if (c.isDone) {
      return Icon(
        Icons.check_circle,
        color: Theme.of(context).accentColor,
        size: 15.0,
      );
    } else if (c.isDone) {
      return Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          shape: BoxShape.circle,
        ),
      );
    }
    return null;
  }
}
