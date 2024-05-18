import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

abstract interface class RemoteDataSource {
  Future<Map<String, dynamic>> createUser(String userName);
}

class RemoteDataSourceImp implements RemoteDataSource {
  @override
  Future<Map<String, dynamic>> createUser(String userName) async {
    final url = Uri.parse('http://localhost:1234/user');

    final body = jsonEncode({"user_name": userName});

    final headers = {"Accept": "*/*", "Content-Type": "application/json"};
    final res = await http.post(url, body: body, headers: headers);
    final data = jsonDecode(res.body);
    print(data);
    return data;
  }
}
