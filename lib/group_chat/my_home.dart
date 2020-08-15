import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/group_chat/model.dart';
import 'package:educationapp/group_chat/utils.dart';
import 'package:educationapp/networking/class_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MyHome extends StatefulWidget {
  int index;
  MyHome({this.index});
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Center(
              child: Text(
                'Join the Chat Room',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "Merriweather",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Container(
                width: 250.0,
                child: SvgPicture.asset('assets/images/chat.svg'),
              ),
            ),
            CustomForm(
              controller: _controller,
              formKey: _formKey,
              hintText: "Enter your username",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: CustomButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    final user = _controller.value.text;
                    final client = provider.client;

                    await client.setUserWithProvider(
                      User(
                        id: "id_$user",
                        extraData: {
                          "name": "$user",
                          "image": "https://picsum.photos/100/100",
                        },
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => StreamChat(
                          child: ChannelView(
                            index: widget.index,
                          ),
                          client: client,
                        ),
                      ),
                    );
                  }
                },
                text: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChannelView extends StatelessWidget {
  int index;
  ChannelView({this.index});
  String classID;
  final firestoreInstance = Firestore.instance;
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final channels = List<Channel>();
  ClassData classData = ClassData();
  Future<List<Channel>> getChannels(StreamChatState state) async {
    final filter = {
      "type": "team",
    };
    final sort = [
      SortOption(
        "last_message_at",
        direction: SortOption.DESC,
      ),
    ];
    return await state.client.queryChannels(
      filter: filter,
      sort: sort,
    );
  }

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
    final streamchat = StreamChat.of(context);
    final client = streamchat.client;
    final provider = Provider.of<ChatModel>(context);

    return Scaffold(
      body: FutureBuilder(
        future: classData.getClassData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: Text(
                    'Join the Doubt Forum',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "Merriweather",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    width: 250.0,
                    child: SvgPicture.asset('assets/images/login.svg'),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 45.0, top: 45.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'All Channels',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                          FutureBuilder(
                            future: getChannels(streamchat),
                            builder:
                                (_, AsyncSnapshot<List<Channel>> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              // clear list to avoid duplicates
                              channels.clear();
                              // repopulate list
                              channels.addAll(snapshot.data);

                              if (snapshot.data.length == 0) {
                                return Container();
                              }
                              return ListView(
                                scrollDirection: Axis.vertical,
                                children: createListOfChannels(
                                    snapshot.data, context),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0, left: 50.0),
                  child: Container(
                    height: 65.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFa055e6),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        '${snapshot.data['Items'][index]['Subject']['S']} - ${snapshot.data['Items'][index]['ClassID']['S']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                    ),
                  ),
                ),
//                CustomForm(
//                  controller: _controller,
//                  formKey: _formKey,
//                  hintText: "Enter channel name",
//                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CustomButton(
                    onPressed: () async {
//                      if (_formKey.currentState.validate()) {
//                        final channelName = _controller.value.text;
                      final channelName =
                          '${snapshot.data['Items'][index]['Subject']['S']}'
                                  .substring(0, 4) +
                              '${snapshot.data['Items'][index]['ClassID']['S']}';
                      final channelTitles = channels.map((e) => e.cid).toList();
                      _controller.clear();
                      final channel = client.channel(
                        "mobile",
                        id: channelName,
                        extraData: {
                          "image": "https://picsum.photos/100/100",
                        },
                      );
                      // match against strings where pattern = mobile:*
                      if (!channelTitles.contains("mobile:$channelName")) {
                        await channel.create();
                      }

                      await channel.watch();

                      provider.currentChannel = channel;

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => StreamChannel(
                            child: ChatPage(),
                            channel: channel,
                          ),
                        ),
                      );
//                      }
                    },
                    text: "Join Channel",
                  ),
                ),
              ],
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
}

class ChatPage extends StatelessWidget {
  Icon likeButton = Icon(Icons.favorite, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    final streamChannel = StreamChannel.of(context);
    final channel = streamChannel.channel;

    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              messageBuilder: (context, msg, idx) {
                final msgReactionCount = msg.reactionCounts ?? {"like": 0};
                return ListTile(
                  leading: Text("${msg.user.name}"),
                  title: Text("${msg.text}"),
                  subtitle: Text("${msg.createdAt.toIso8601String()}"),
                  trailing: Text("Likes: ${msgReactionCount["like"] ?? 0}"),
                  onTap: () async {
                    await channel.sendReaction(msg.id, "like");
                  },
                );
              },
            ),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
