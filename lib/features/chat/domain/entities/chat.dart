class Chat {
  String message;
  DateTime time;
  String userName;
  bool isMe;
  Chat(
      {required this.message,
      required this.time,
      required this.userName,
      this.isMe = false});
}
