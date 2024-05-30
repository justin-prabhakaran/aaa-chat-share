import 'dart:async';
import 'dart:convert';
import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/data/models/chat_model.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  Future<bool> sendChat(String message, String userName, DateTime time);
  Future<List<ChatModel>> getAllChat();
  Stream<Chat> listenOnChat();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final StreamController<Chat> _streamController = StreamController<Chat>.broadcast();
  final io.Socket _socket;

  ChatRemoteDataSourceImpl({required io.Socket socket})
      : _socket = socket {
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

    _socket.on('updatemessage', (data) {
      final jsond = jsonDecode(data);
      final res = ChatModel.fromMap(jsond);
      _streamController.add(res as Chat);
    });
  }

  @override
  Future<bool> sendChat(String message, String userName, DateTime time) async {
    final url = Uri.parse('http://localhost:1234/chat');
    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json"
    };
    final body = jsonEncode({
      'message': message,
      'user_name': userName,
      'time': time.millisecondsSinceEpoch,
      'socketId': _socket.id,
    });

    try {
      final res = await http.post(url, headers: headers, body: body);
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Failure('Failed to send chat: ${res.statusCode}');
      }
    } catch (e) {
      print('Error sending chat: $e');
      return false;
    }
  }

  @override
  Future<List<ChatModel>> getAllChat() async {
    final url = Uri.parse('http://localhost:1234/chat');

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> decodedBody = jsonDecode(res.body);
        return decodedBody.map<ChatModel>((chat) => ChatModel.fromMap(chat)).toList();
      } else {
        throw Failure('Failed to get all chat: ${res.statusCode}');
      }
    } catch (e) {
      print('Error getting all chat: $e');
      throw Failure('Something went wrong: $e');
    }
  }

  @override
  Stream<Chat> listenOnChat() {
    return _streamController.stream;
  }

  void dispose() {
    _streamController.close();
  }
}
