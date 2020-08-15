import 'package:educationapp/dashboard/class_id_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'FadeAnim.dart';
import 'package:http/http.dart';
import 'package:educationapp/dashboard/dashboard.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class CreateClass extends StatefulWidget {
  static String id = 'sign_up_page';
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  String cid;
  String Sub;
  String add;
  String org;
  String pin;
  String clas;
  String prof;

  bool isHidden = true;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

//  _makePostRequest() async {
//    // set up POST request arguments
//    String url = 'https://jsonplaceholder.typicode.com/posts';
//    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{
//    "title": "Hello",
//    "body": "body text",
//    "userId": 1
//    }';
//    // make POST request
//    Response response = await post(url, headers: headers, body: json);
//    // check the status code for the result
//    int statusCode = response.statusCode;
//    // this API passes back the id of the new item added to the body
//    String body = response.body;
//    // {
//    //   "title": "Hello",
//    //   "body": "body text",
//    //   "userId": 1,
//    //   "id": 101
//    // }
//  }
//  {
//  "Address": "Full address, with Pincode",
//  "Class": "12 D",
//  "ClassID": "DAVXIID",
//  "Org-name": "Dav Public School",
//  "Prof": "RD Sharma",
//  "Schedule": {
//  }

  _makePostRequest(String cid, String Sub, String add, String org, String clss,
      String prof) async {
    // set up POST requtgest arguments
    String url =
        'https://2b9qafqhs6.execute-api.ap-south-1.amazonaws.com/v2/xyz/ztx';
    Map<String, String> headers = {"Content-type": "application/json"};
    print(cid);
    print(Sub);
    print(add);
    print(org);
    String json =
        '{"cid": "$cid", "sub": "$Sub", "add": "$add", "org": "$org", "schedule": {"0": {"Period": "10:00 - 12:00"},"1": {"Period": "10:00 - 12:00"},"2": {"Period": "15:00 - 12:00"}}, "clss": "$clss", "prof": "$prof" }';
    // make POST request
    // check the status code for the result

    if (cid == null || Sub == null || add == null || org == null) {
      _showErrorDialog('Please Fill all the fields');
    } else {
      Response response = await post(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print(statusCode);
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: ClassIDPage()));
    }
  }

  Widget _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text('Authentication Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorMessage),
                ],
              ),
            ),
            actions: <Widget>[
              PlatformDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              PlatformDialogAction(
                child: Text('Ok'),
                actionType: ActionType.Preferred,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

//  _makePostRequest() async {
//    // set up POST request arguments
//    String url = 'https://jsonplaceholder.typicode.com/posts';
//    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{"title": "Hello", "body": "body text", "userId": 1}';
//    // make POST request
//    Response response = await post(url, headers: headers, body: json);
//    // check the status code for the result
//    int statusCode = response.statusCode;
//    // this API passes back the id of the new item added to the body
//    String body = response.body;
//    // {
//    //   "title": "Hello",
//    //   "body": "body text",
//    //   "userId": 1,
//    //   "id": 101
//    // }
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Your Channel",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "Create a channel for your students",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 25.0),
                    FadeAnimation(
                      1.2,
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Name of the Organization",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF6F35A5), width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF6F35A5), width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.school,
                              color: Colors.black54,
                            )),
                        onChanged: (value) {
                          org = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FadeAnimation(
                      1.2,
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF6F35A5), width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF6F35A5), width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.black54,
                            )),
                        onChanged: (value) {
                          add = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FadeAnimation(
                      1.2,
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Pin Code",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF6F35A5), width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF6F35A5), width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.black54,
                            )),
                        onChanged: (value) {
                          pin = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FadeAnimation(
                      1.3,
                      TextField(
                        obscureText: isHidden == true ? true : false,
                        decoration: InputDecoration(
                          hintText: "Channel ID",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 2.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                            color: Colors.black,
                            onPressed: toggleVisibility,
                            icon: isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        onChanged: (value) {
                          cid = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FadeAnimation(
                      1.3,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Subject",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 2.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.book,
                            color: Colors.black54,
                          ),
                        ),
                        onChanged: (value) {
                          Sub = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FadeAnimation(
                      1.3,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Channel name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 2.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.lightbulb_outline,
                            color: Colors.black54,
                          ),
                        ),
                        onChanged: (value) {
                          clas = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FadeAnimation(
                      1.3,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Faculty Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF6F35A5), width: 2.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                        ),
                        onChanged: (value) {
                          prof = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                FadeAnimation(
                  1.5,
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0, right: 55.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          color: Color(0xFF6F35A5),
                          onPressed: () {
                            _makePostRequest(
                                cid, Sub, "$add , $pin", org, clas, prof);
                          },
                          child: Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == "Password"
            ? IconButton(
                onPressed: toggleVisibility,
                icon: isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == "Password" ? isHidden : false,
    );
  }
}
