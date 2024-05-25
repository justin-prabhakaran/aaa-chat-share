import 'dart:convert';

import 'dart:typed_data';

import 'package:aaa_chat_share/features/chat/data/models/file_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RemoteFileDataSource {
  Future<List<FileModle>> getAllFiles();
  Future<bool> upladFile(Uint8List file, String userId, String fileName);
}

class RemoteFileDataSourceImpl implements RemoteFileDataSource {
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
}
