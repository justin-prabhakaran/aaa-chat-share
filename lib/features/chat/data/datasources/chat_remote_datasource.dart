import 'dart:async';

import 'package:aaa_chat_share/features/chat/data/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract interface class ChatRemoteDataSource {
  void sendChat(String message, String userName, DateTime time);
  Stream<ChatModel> listen();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final StreamController<ChatModel> _streamController =
      StreamController<ChatModel>();
  final Socket _socket;
  ChatRemoteDataSourceImpl()
      : _socket = io(
          Uri.parse('http://localhostL:1234'),
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build(),
        ) {
    _socket.on(
      'message',
      (data) {
        print(data);
        ChatModel chat = ChatModel.fromMap(data);

        _streamController.add(chat);
      },
    );
  }

  @override
  Stream<ChatModel> listen() {
    return _streamController.stream;
  }

  @override
  void sendChat(String message, String userName, DateTime time) {
    _socket.emit('message', {
      'message': message,
      'user_name': userName,
      'time': time.millisecondsSinceEpoch
    });
  }
}
