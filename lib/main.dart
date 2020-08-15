import 'package:educationapp/dashboard/class_id_page.dart';
import 'package:educationapp/dashboard/dashboard.dart';
import 'package:educationapp/login/login.dart';
import 'package:educationapp/sign_up/sign_up.dart';
import 'package:educationapp/time_table/time_table.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      initialRoute: Dashboard.id,
//      routes: {
//        Dashboard.id: (context) => Dashboard(),
//      },
      home: FutureBuilder(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ClassIDPage();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
