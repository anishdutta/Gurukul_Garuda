import 'package:educationapp/networking/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassData {
  getClassData() async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://z3kg0czfub.execute-api.ap-south-1.amazonaws.com/v1/classid/DAVXIID');
    var doctorData = await networkHelper.getData();
    return doctorData;
  }
}
