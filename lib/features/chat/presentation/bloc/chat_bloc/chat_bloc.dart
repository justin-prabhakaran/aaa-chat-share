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
    on<ChatEvent>((event, emit) {
      emit(ChatLoadingState());
    });

    on<ChatSendEvent>(_chatSendEvent);
    on<ChatStartedEvent>(_chatStartedEvent);
    on<ChatSendMyMessage>(_chatSendMyMessage);
  }

  _chatSendEvent(ChatSendEvent event, Emitter<ChatState> emit) {
    _sendChat(ChatSendParams(
        message: event.message, userName: event.userName, time: event.time));
  }

  _chatStartedEvent(ChatStartedEvent event, Emitter<ChatState> emit) {
    var list = _listenChat(NoParams());

    list.fold(
        (failure) => emit(
              ChatFailureState(failure: failure),
            ), (stream) {
      stream.listen((chat) {
        chats.add(chat);
        emit(
          ChatRecievedState(
            chat: List<Chat>.from(chats),
          ),
        );
      });
    });
  }

  _chatSendMyMessage(ChatSendMyMessage event, Emitter<ChatState> emit) {
    chats.add(event.chat);
    emit(
      ChatRecievedState(
        chat: List<Chat>.from(chats),
      ),
    );
  }
}
