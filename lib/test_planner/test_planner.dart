import 'package:educationapp/test_planner/header.dart';
import 'package:educationapp/test_planner/recent_alerts.dart';
import 'package:educationapp/test_planner/recent_homeworks.dart';
import 'package:educationapp/utilities/constants.dart';
import 'package:flutter/material.dart';

class TestPlannerHome extends StatefulWidget {
  @override
  _TestPlannerHomeState createState() => _TestPlannerHomeState();
}

class _TestPlannerHomeState extends State<TestPlannerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Header(),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.all(35.0),
              decoration: BoxDecoration(
                color: Color(0xFFAFC8FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Recent Alerts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  RecentsAlerts(),
                  SizedBox(height: 10.0),
                  Text(
                    "Recent Homework",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  RecentHomeworks(),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
