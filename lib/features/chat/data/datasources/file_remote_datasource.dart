import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../core/failure.dart';
import '../models/file_model.dart';

abstract interface class FileRemoteDataSource {
  Future<List<FileModle>> getAllFiles();
  Future<bool> upladFile(Uint8List file, String userId, String fileName);

  Stream<void> listenOnFiles();
}

class FileRemoteDataSourceImpl implements FileRemoteDataSource {
  var serverUrlBase = dotenv.env['SERVER_URL_BASE'];
  final StreamController<void> _streamController = StreamController<void>();
  final io.Socket _socket;

  FileRemoteDataSourceImpl({required io.Socket socket}) : _socket = socket {
    _socket.on('connect', (_) {
      print('Message :: Connected to file socket server');
    });

    _socket.on('disconnect', (_) {
      print('Message :: Disconnected from file socket server');
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
    final url = Uri.parse('$serverUrlBase/upload');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var jsnonList = jsonDecode(res.body) as List;
      List<FileModle> files =
          jsnonList.map<FileModle>((file) => FileModle.fromMap(file)).toList();

      return files;
    } else {
      throw Failure('Something went wrong!');
    }
  }

  @override
  Future<bool> upladFile(
      Uint8List bytes, String userId, String fileName) async {
    final url = Uri.parse('$serverUrlBase/upload');
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
