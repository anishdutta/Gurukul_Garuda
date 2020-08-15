import 'package:educationapp/group_chat/model.dart';
import 'package:educationapp/group_chat/my_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMainFile extends StatefulWidget {
  int index;
  ChatMainFile({this.index});
  @override
  _ChatMainFileState createState() => _ChatMainFileState();
}

class _ChatMainFileState extends State<ChatMainFile> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatModel>(
      create: (context) => ChatModel(),
      child: MaterialApp(
        theme: ThemeData(),
        home: MyHome(
          index: widget.index,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
