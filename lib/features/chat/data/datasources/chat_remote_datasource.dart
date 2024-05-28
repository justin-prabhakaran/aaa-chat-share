import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:aaa_chat_share/features/chat/data/models/chat_model.dart';

abstract class ChatRemoteDataSource {
  void sendChat(String message, String userName, DateTime time);
  StreamController<ChatModel> listen();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final StreamController<ChatModel> _streamController =
      StreamController<ChatModel>.broadcast();
  late final io.Socket _socket;

  ChatRemoteDataSourceImpl() {
    _socket = io.io(
      'http://localhost:1234',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    _socket.on('connect', (_) {
      print('Message :: Connected to chat socket server');
    });

    _socket.on('message', (data) {
      print(data);
      ChatModel chat = ChatModel.fromMap(data);
      _streamController.add(chat);
    });

    _socket.on('disconnect', (_) {
      print('Message :: Disconnected from chat socket server');
    });

    if (!_socket.connected) {
      _socket.connect();
    }
  }

  @override
  StreamController<ChatModel> listen() {
    return _streamController;
  }

  @override
  void sendChat(String message, String userName, DateTime time) {
    Map<String, dynamic> data = {
      'message': message,
      'user_name': userName,
      'time': time.millisecondsSinceEpoch
    };
    var jsondata = jsonEncode(data);
    print(jsondata);
    _socket.emit('message', jsondata);
  }

  // Remember to close the stream controller when done
  void dispose() {
    _streamController.close();
    _socket.dispose();
  }
}
