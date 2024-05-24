part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

// class ChatSendEvent extends ChatEvent {
//   final String message;
//   final String userName;
//   final DateTime time;

//   const ChatSendEvent(
//       {required this.message, required this.userName, required this.time});
// }

class ChatRecievedEvent extends ChatEvent {
  final Chat chat;

  const ChatRecievedEvent({required this.chat});
}

class ChatStartedEvent extends ChatEvent {}

class ChatSendMyMessage extends ChatEvent {
  final Chat chat;

  const ChatSendMyMessage({required this.chat});
}
