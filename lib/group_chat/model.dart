import 'package:educationapp/group_chat/api.dart';
import 'package:flutter/material.dart';
import 'package:start_jwt/json_web_token.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatModel extends ChangeNotifier {
  ChatModel() {
    _client = Client(
      APIKEY,
      logLevel: Level.SEVERE,
      tokenProvider: provider,
    );
  }

  Client _client;
  String _channelName;
  Channel _currentChannel;

  String get channelName => _channelName;
  set channelName(String value) {
    _channelName = value;
    notifyListeners();
  }

  set currentChannel(Channel channel) {
    _currentChannel = channel;
    notifyListeners();
  }

  Client get client => _client;
}

Future<String> provider(String id) async {
  final JsonWebTokenCodec jwt = JsonWebTokenCodec(secret: SECRET);

  final payload = {
    "user_id": id,
  };

  return jwt.encode(payload);
}
