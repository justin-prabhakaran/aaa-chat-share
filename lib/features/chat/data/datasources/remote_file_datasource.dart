import 'dart:convert';

import 'package:aaa_chat_share/features/chat/data/models/file_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RemoteFileDataSource {
  Future<List<FileModle>> getAllFiles();
}

class RemoteFileDataSourceImpl implements RemoteFileDataSource {
  @override
  Future<List<FileModle>> getAllFiles() async {
    final url = Uri.parse('http://localhost:1234/upload');
    var res = await http.get(url);
    var jsnonList = jsonDecode(res.body) as List;
    print(res.body);
    List<FileModle> files =
        jsnonList.map<FileModle>((file) => FileModle.fromMap(file)).toList();

    return files;
  }
}
