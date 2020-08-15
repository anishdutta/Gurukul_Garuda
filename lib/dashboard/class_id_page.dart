import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:educationapp/dashboard/dashboard.dart';
import 'package:educationapp/dashboard/rounded_input_field.dart';
import 'package:educationapp/database/database.dart';
import 'package:educationapp/networking/class_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class ClassIDPage extends StatefulWidget {
  @override
  _ClassIDPageState createState() => _ClassIDPageState();
}

class _ClassIDPageState extends State<ClassIDPage> {
  ClassData classData = ClassData();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  String Code;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 70.0,
            ),
            Center(
              child: TypewriterAnimatedTextKit(
                  displayFullTextOnTap: true,
                  repeatForever: true,
                  speed: Duration(milliseconds: 500),
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Join your Class",
                  ],
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/images/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.09),
            RoundedInputField(
              hintText: "Class Code",
              onChanged: (value) {
                Code = value;
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Color(0xFF6F35A5),
                  onPressed: () {
                    Database(uid: loggedInUser.uid).updateUserData3('$Code');
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Dashboard()));
                  },
                  child: Text(
                    'Proceed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
