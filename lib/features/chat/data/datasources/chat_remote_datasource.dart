import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/failure.dart';
import '../models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  void sendChat(String message, String userName, DateTime time);
  Future<List<ChatModel>> getAllChat();

  Stream<ChatModel> listonOnChat();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  var serverUrlBase = dotenv.env['SERVER_URL_BASE'];

  final StreamController<ChatModel> _streamController =
      StreamController<ChatModel>();

  final io.Socket _socket;

  ChatRemoteDataSourceImpl({required io.Socket socket}) : _socket = socket {
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket.on('connect', (_) {
      print('Message :: Connected to chat socket server');
    });

    _socket.on('disconnect', (_) {
      print('Message :: Disconnected from chat socket server');
    });

    if (!_socket.connected) {
      _socket.connect();
    }

    _socket.on('message', (data) {
      _streamController.add(ChatModel.fromJson(data));
    });
  }

  @override
  Future<List<ChatModel>> getAllChat() async {
    final url = Uri.parse('$serverUrlBase/chat');

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> decodedBody = jsonDecode(res.body);
        return decodedBody
            .map<ChatModel>((chat) => ChatModel.fromMap(chat))
            .toList();
      } else {
        throw Failure('Failed to get all chat: ${res.statusCode}');
      }
    } catch (e) {
      throw Failure('Something went wrong: $e');
    }
  }

  @override
  Stream<ChatModel> listonOnChat() {
    return _streamController.stream;
  }

  @override
  void sendChat(String message, String userName, DateTime time) {
    _socket.emit('message',
        ChatModel(message: message, userName: userName, time: time).toJson());
  }
}
