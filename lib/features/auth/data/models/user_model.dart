import 'package:aaa_chat_share/features/auth/domain/entities/user_entity.dart';

class UserModle extends User {
  UserModle({required super.userId, required super.userName});

  UserModle copyWith({
    String? userId,
    String? userName,
  }) {
    return UserModle(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'user_name': userName,
    };
  }

  factory UserModle.fromMap(Map<String, dynamic> map) {
    return UserModle(
      userId: map['user_id'] as String,
      userName: map['user_name'] as String,
    );
  }

  @override
  String toString() => 'User(userId: $userId, userName: $userName)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.userName == userName;
  }

  @override
  int get hashCode => userId.hashCode ^ userName.hashCode;
}
