import 'package:educationapp/dashboard/text_field_cont.dart';
import 'package:educationapp/group_chat/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final GlobalKey formKey;
  final TextEditingController controller;

  const CustomForm({
    Key key,
    this.hintText,
    this.formKey,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: TextFieldContainer(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Color(0xFF6F35A5),
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),
            validator: (input) {
              if (input.isEmpty) {
                return "Enter some Text";
              }
              if (input.contains(RegExp(r"^([A-Za-z0-9]){4,20}$"))) {
                return null;
              }
              return "Can not contain special characters or spaces.";
            },
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 65.0, right: 65.0, bottom: 20.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: Color(0xFF6F35A5),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> createListOfChannels(List<Channel> channels, context) {
  final provider = Provider.of<ChatModel>(context);

  return channels
      // convert to list to gain access to the index and make deletion more reliable.
      .asMap()
      .map((idx, chan) => MapEntry(
          idx,
          ListTile(
            // unique key makes it easier for the streamview to know which ListTile is which.
            key: UniqueKey(),
            title: Text(
              "Channel Title: ${chan.cid.replaceFirstMapped("mobile:", (match) => "")}",
            ),
            subtitle: Text("Last Message at: ${chan.lastMessageAt}"),
            trailing: Text("Peers: ${chan.state.members.length}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  chan.extraData["image"] ?? "https://picsum.photos/100/100"),
            ),
            onLongPress: () async {
              // remove channel from list.
              channels.removeAt(idx);
              provider.currentChannel = chan;
              await chan.delete();
            },
          )))
      .values
      .toList();
}
