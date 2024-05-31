import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  static var tokenKey = dotenv.env['TOKEN_KEY_SECURE_STORAGE'] ?? '';
  var serverUrlBase = dotenv.env['SERVER_URL_BASE'] ?? '';
  @override
  Future<Map<String, dynamic>> createUser(String userName) async {
    final url = Uri.parse('$serverUrlBase/user');

    final body = jsonEncode({"user_name": userName});

    final headers = {"Accept": "*/*", "Content-Type": "application/json"};
    final res = await http.post(url, body: body, headers: headers);
    final data = jsonDecode(res.body);
    return data;
  }

  @override
  Future<Map<String, dynamic>> isUserLoggedIn() async {
    var res = await _storage.read(key: tokenKey);
    if (res != null) {
      final data = await getUser(res);
      return data;
    }
    return {};
  }

  @override
  Future<void> removeUserLoggedIn() async {
    await _storage.delete(key: tokenKey);
  }

  @override
  Future<void> saveUserLoggedIn(String key) async {
    await _storage.write(key: tokenKey, value: key);
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    final query = {'user_id': userId};
    final url = Uri.http(serverUrlBase, '/user', query);
    final headers = {"Accept": "*/*", "Content-Type": "application/json"};
    final res = await http.get(url, headers: headers);
    final data = jsonDecode(res.body);

    return data;
  }
}
