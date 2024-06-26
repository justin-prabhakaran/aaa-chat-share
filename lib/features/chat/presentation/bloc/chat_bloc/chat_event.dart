part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatGetAllChatEvent extends ChatEvent {}

class ChatSendMyMessageEvent extends ChatEvent {
  final Chat chat;

  const ChatSendMyMessageEvent({required this.chat});

  @override
  List<Chat> get props => [chat];
}

class ChatRecievedEvent extends ChatEvent {
  final Chat chat;
  const ChatRecievedEvent({required this.chat});

  @override
  List<Chat> get props => [chat];
}

class ChatStartedListenEvent extends ChatEvent {}
