import 'dart:async';
import 'dart:convert';
import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/data/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  Future<bool> sendChat(String message, String userName, DateTime time);
  Future<List<ChatModel>> getAllChat();
  Stream<void> listonOnChat();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final StreamController<void> _streamController;
  final io.Socket _socket;

  ChatRemoteDataSourceImpl(
      {required io.Socket socket,
      required StreamController<void> streamController})
      : _socket = socket,
        _streamController = streamController {
    _socket.on('connect', (_) {
      print('Message :: Connected to chat socket server');
    });

    _socket.on('disconnect', (_) {
      print('Message :: Disconnected from chat socket server');
    });

    if (!_socket.connected) {
      _socket.connect();
    }

    _socket.on('updatemessage', (_) {
      _streamController.add(null);
    });
  }

  @override
  Future<bool> sendChat(String message, String userName, DateTime time) async {
    final url = Uri.parse('http://localhost:1234');
    final headers = {"Accept": "*/*", "Content-Type": "application/json"};
    final body = jsonEncode({
      'message': message,
      'user_name': userName,
      'time': time.millisecondsSinceEpoch,
    });
    final res = await http.post(url, headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<ChatModel>> getAllChat() async {
    final url = Uri.parse('http://localhost:1234');

    final res = await http.get(url);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List)
          .map<ChatModel>((chat) => ChatModel.fromMap(chat))
          .toList();
    } else {
      throw Failure('Something Went Error');
    }
  }

  @override
  Stream<void> listonOnChat() {
    return _streamController.stream;
  }
}
