import 'dart:async';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/get_all_chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/listen_chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/send_chat.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendChat _sendChat;
  final ListenOnChat _listenOnChat;
  final GetAllChat _getAllChat;
  List<Chat> chats = [];

  ChatBloc(
      {required SendChat sendChat,
      required ListenOnChat listenOnChat,
      required GetAllChat getAllChat})
      : _sendChat = sendChat,
        _listenOnChat = listenOnChat,
        _getAllChat = getAllChat,
        super(ChatInitial()) {
    on<ChatSendMyMessageEvent>(_chatSendMyMessageEvent);
    on<ChatGetAllChatEvent>(_chatGetAllChatEvent);
    on<ChatStartedListenEvent>(_chatStartedListenEvent);
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

  FutureOr<void> _chatSendMyMessageEvent(
      ChatSendMyMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final res = await _sendChat(SendChatParams(
          message: event.chat.message,
          userId: event.chat.userName,
          time: event.chat.time));
      res.fold((failure) {
        emit(ChatFailureState(failure: failure));
      }, (success) {
        if (success) {
          chats.add(event.chat);
          print('message sended : ${event.chat.message}');
          emit(ChatRecievedState(chats: List<Chat>.from(chats)));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(ChatFailureState(failure: Failure(e.toString())));
    }
  }

  FutureOr<void> _chatGetAllChatEvent(
      ChatGetAllChatEvent event, Emitter<ChatState> emit) async {
    try {
      final res = await _getAllChat(NoParams());
      res.fold((failure) => emit(ChatFailureState(failure: failure)), (schats) {
        chats = List.from(schats);
        emit(ChatRecievedState(chats: schats));
      });
    } catch (e) {
      print(e.toString());
      emit(ChatFailureState(failure: Failure(e.toString())));
    }
  }

  FutureOr<void> _chatStartedListenEvent(
      ChatStartedListenEvent event, Emitter<ChatState> emit) {
    try {
      final res = _listenOnChat(NoParams());
      res.fold((failure) => emit(ChatFailureState(failure: failure)), (stream) {
        stream.listen((chat) {
          chats.add(chat);
          emit(ChatRecievedState(chats: List<Chat>.from(chats)));
          // add(ChatGetAllChatEvent());
        });
      });
    } catch (e) {
      print(e.toString());
      emit(ChatFailureState(failure: Failure(e.toString())));
    }
  }
}
