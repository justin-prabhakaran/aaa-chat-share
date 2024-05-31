import 'dart:convert';

import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:flutter/foundation.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.message,
    required super.time,
    required super.userName,
  });

  ChatModel copyWith({
    String? message,
    DateTime? time,
    String? userName,
  }) {
    return ChatModel(
      message: message ?? this.message,
      time: time ?? this.time,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'time': time.millisecondsSinceEpoch,
      'user_name': userName,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: map['message'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      userName: map['user_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() =>
      'Chat(message: $message, time: $time, userName: $userName)';

  Chat toEntity() {
    return Chat(message: message, time: time, userName: userName);
  }
}
