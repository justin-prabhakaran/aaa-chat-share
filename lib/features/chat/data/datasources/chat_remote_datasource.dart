import 'dart:async';

import 'package:aaa_chat_share/features/chat/data/datasources/socket_api.dart';
import 'package:aaa_chat_share/features/chat/data/models/chat_model.dart';

abstract interface class ChatRemoteDataSource {
  void sendChat(String message, String userName, DateTime time);
  Stream<ChatModel> listen();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final StreamController<ChatModel> _streamController;
  final SocketApi _socketApi;
  ChatRemoteDataSourceImpl({
    required SocketApi socketApi,
    required StreamController<ChatModel> streamController,
  })  : _streamController = streamController,
        _socketApi = socketApi {
    _socketApi.socket.on(
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
    _socketApi.socket.emit('message', {
      'message': message,
      'user_name': userName,
      'time': time.millisecondsSinceEpoch
    });
  }
}
