import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:aaa_chat_share/features/chat/data/models/file_model.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

abstract interface class FileRemoteDataSource {
  Future<List<FileModle>> getAllFiles();
  Future<bool> upladFile(Uint8List file, String userId, String fileName);

  Stream<void> listenOnFiles();
}

class FileRemoteDataSourceImpl implements FileRemoteDataSource {
  final StreamController<void> _streamController = StreamController<void>();
  late io.Socket _socket;

  FileRemoteDataSourceImpl() {
    _socket = io.io(
        'http://localhost:1234',
        io.OptionBuilder()
            .setTransports(['websockets'])
            .disableAutoConnect()
            .build());

    _socket.on('connect', (_) {
      print('Connected to file socket server');
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from file socket server');
    });

    _socket.on('updatefiles', (_) {
      _streamController.add(null);
    });

    if (!_socket.connected) {
      _socket.connect();
    }
  }

  @override
  Future<List<FileModle>> getAllFiles() async {
    final url = Uri.parse('http://localhost:1234/upload');
    var res = await http.get(url);
    var jsnonList = jsonDecode(res.body) as List;
    List<FileModle> files =
        jsnonList.map<FileModle>((file) => FileModle.fromMap(file)).toList();

    return files;
  }

  @override
  Future<bool> upladFile(
      Uint8List bytes, String userId, String fileName) async {
    final url = Uri.parse('http://localhost:1234/upload');
    var req = http.MultipartRequest('post', url);
    req.fields['file_size'] = bytes.length.toString();
    req.fields['user_id'] = userId;
    req.files
        .add(http.MultipartFile.fromBytes('file', bytes, filename: fileName));

    var res = await req.send();
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Stream<void> listenOnFiles() {
    return _streamController.stream;
  }
}
