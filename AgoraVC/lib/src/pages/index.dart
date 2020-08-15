import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

//import 'package:permission_handler/permission_handler.dart';

import './call.dart';

class IndexPage extends StatefulWidget   {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Center(
                    child: Image.network(
                      'https://i.ibb.co/MPKM4Xj/Young-man-videoconferencing-with-colleagues-on-laptop.jpg',
                      scale: 1,
                    )

                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(

                          controller: _channelController,
                          decoration: InputDecoration(
                            errorText:
                            _validateError ? 'Channel name is mandatory' : null,

                            hintText: 'Channel name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.purple, width: 1.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.purple, width: 2.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(13.0)),

                            ),
                            prefixIcon: Icon(
                              Icons.videocam,
                              color: Colors.purple,
                            )
                          ),

                        ))
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(ClientRole.Broadcaster.toString()),
                      leading: Radio(
                        value: ClientRole.Broadcaster,
                        groupValue: _role,
                        onChanged: (ClientRole value) {
                          setState(() {
                            _role = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(ClientRole.Audience.toString()),
                      leading: Radio(
                        value: ClientRole.Audience,
                        groupValue: _role,
                        onChanged: (ClientRole value) {
                          setState(() {
                            _role = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      RaisedButton(
//                    https://www.vectorstock.com/royalty-free-vector/tablet-pc-with-internet-conference-app-director-vector-21321144
                      onPressed: onJoin,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),

                        padding: EdgeInsets.all(0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.purple,
                                Colors.purple[800]
                              ]),
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            constraints:
                            BoxConstraints(maxWidth: 260.0, minHeight: 60.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Join",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 28),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
