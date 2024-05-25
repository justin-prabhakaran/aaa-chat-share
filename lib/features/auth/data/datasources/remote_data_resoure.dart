import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract interface class RemoteDataSource {
  Future<Map<String, dynamic>> createUser(String userName);
  Future<Map<String, dynamic>> isUserLoggedIn();
  Future<void> removeUserLoggedIn();
  Future<void> saveUserLoggedIn(String key);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final _storage = const FlutterSecureStorage();
  static const toker_key = "auth_token";

  @override
  Future<Map<String, dynamic>> createUser(String userName) async {
    final url = Uri.parse('http://localhost:1234/user');

    final body = jsonEncode({"user_name": userName});

    final headers = {"Accept": "*/*", "Content-Type": "application/json"};
    final res = await http.post(url, body: body, headers: headers);
    final data = jsonDecode(res.body);
    // print(data);
    return data;
  }

  @override
  Future<Map<String, dynamic>> isUserLoggedIn() async {
    var res = await _storage.read(key: toker_key);
    print('this is res :  $res');
    if (res != null) {
      final data = await getUser(res);
      print('this is data : $data');
      return data;
    }
    return {};
  }

  @override
  Future<void> removeUserLoggedIn() async {
    await _storage.delete(key: toker_key);
  }

  @override
  Future<void> saveUserLoggedIn(String key) async {
    await _storage.write(key: toker_key, value: key);
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    // final url = Uri.parse('http://localhost:1234/user');

    final query = {'user_id': userId};
    final url = Uri.http('localhost:1234', '/user', query);
    final headers = {"Accept": "*/*", "Content-Type": "application/json"};
    final res = await http.get(url, headers: headers);
    final data = jsonDecode(res.body);
    print(data);
    return data;
  }
}
