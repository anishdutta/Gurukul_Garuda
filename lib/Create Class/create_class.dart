import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'FadeAnimation.dart';
import 'package:http/http.dart';


class CreateClass extends StatefulWidget {
  static String id = 'sign_up_page';
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  String username;
  String email;
  String password;
  String address;

  bool isHidden = true;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;

    });
  }
  _makePostRequest() async {
    // set up POST requtgest arguments
    String url = 'https://2b9qafqhs6.execute-api.ap-south-1.amazonaws.com/v2/xyz/ztx';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{'
        '"cid": "DAVXIID", '
        '"sub": "PE", '
        '"add": "sdjcnnksbcisdjdchdk"'
        '}';
    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
//    {
//      "cid" : "DAVXIID",
//    "sub" : "Chemi",
//    "add" : "skdjcjk",
//    "org" : "xyz",
//    "schedule" :"schedule"
//    }
  print(statusCode);
  }
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
                          "Create a channel, It's free.",
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
                                  color: Colors.teal, width: 1.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal, width: 2.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black54,
                            )),
                        onChanged: (value) {
                          value = username;
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
                                  color: Colors.teal, width: 1.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal, width: 2.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.black54,
                            )),
                        onChanged: (value) {
                          value = email;
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
                                  color: Colors.teal, width: 1.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal, width: 2.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.black54,
                            )),
                        onChanged: (value) {
                          value = email;
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
                                color: Colors.teal, width: 1.5),
                            borderRadius:
                            BorderRadius.all(Radius.circular(13.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.teal, width: 2.5),
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
                          value = password;
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
                  Container(
                    height: 55,
                    child: RaisedButton(
                      onPressed: () {
                        _makePostRequest();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(25, 103, 97, 1.0),
                              Color.fromRGBO(25, 50, 71, 1.0)
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          constraints:
                          BoxConstraints(maxWidth: 260.0, minHeight: 60.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
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