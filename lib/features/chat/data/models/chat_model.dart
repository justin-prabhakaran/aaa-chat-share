import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel(
      {required super.message,
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
      'userName': userName,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: map['message'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      userName: map['user_name'] as String,
    );
  }

  @override
  String toString() =>
      'Chat(message: $message, time: $time, userName: $userName)';
}
