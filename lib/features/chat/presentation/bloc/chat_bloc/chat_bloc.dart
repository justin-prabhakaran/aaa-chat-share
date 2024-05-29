import 'dart:async';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/listen_chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/send_chat.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendChat _sendChat;
  final ListenChat _listenChat;
  List<Chat> chats = [];

  ChatBloc({
    required SendChat sendChat,
    required ListenChat listenChat,
  })  : _sendChat = sendChat,
        _listenChat = listenChat,
        super(ChatInitial()) {
    on<ChatStartedEvent>(_chatStartedEvent);
    on<ChatSendMyMessage>(_chatSendMyMessage);
  }

  @override
  void onEvent(ChatEvent event) {
    print(event.toString());
    super.onEvent(event);
  }

  @override
  void onChange(Change<ChatState> change) {
    print(change.toString());
    super.onChange(change);
  }

  @override
  void onTransition(Transition<ChatEvent, ChatState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

  FutureOr<void> _chatStartedEvent(
      ChatStartedEvent event, Emitter<ChatState> emit) {
    var listen = _listenChat(NoParams());
    listen.fold(
      (failure) {
        emit(ChatFailureState(failure: failure));
      },
      (streamc) async {
        await emit.onEach<Chat>(streamc.stream,
            onData: (chat) => ChatRecievedState(chats: List<Chat>.from(chats)));
      },
    );
  }

  FutureOr<void> _chatSendMyMessage(
      ChatSendMyMessage event, Emitter<ChatState> emit) {
    var res = _sendChat(
      SendChatParams(
        message: event.chat.message,
        userName: event.chat.userName,
        time: event.chat.time,
      ),
    );
    res.fold((failure) {
      emit(ChatFailureState(failure: failure));
    }, (_) {
      //this will be handled on stream listenor because socket.io will emit msg to all user include this socket
    });
  }
}
