part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatRecievedState extends ChatState {
  final List<Chat> chats;

  const ChatRecievedState({required this.chats});
}

class ChatFailureState extends ChatState {
  final Failure failure;

  const ChatFailureState({required this.failure});
}
