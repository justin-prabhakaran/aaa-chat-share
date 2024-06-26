import 'dart:async';

import '../../../../../core/failure.dart';
import '../../../../../core/usecase.dart';
import '../../../domain/entities/chat.dart';
import '../../../domain/usecases/get_all_chat.dart';
import '../../../domain/usecases/listen_chat.dart';
import '../../../domain/usecases/send_chat.dart';

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
    on<ChatRecievedEvent>(_chatRecievedEvent);
  }


  FutureOr<void> _chatSendMyMessageEvent(
      ChatSendMyMessageEvent event, Emitter<ChatState> emit) {
    try {
      final res = _sendChat(SendChatParams(
          message: event.chat.message,
          userId: event.chat.userName,
          time: event.chat.time));
      res.fold((failure) {
        emit(ChatFailureState(failure: failure));
      }, (success) {
        add(ChatRecievedEvent(chat: event.chat));

      });
    } catch (e) {
      emit(ChatFailureState(failure: Failure(e.toString())));
    }
  }

  FutureOr<void> _chatGetAllChatEvent(
      ChatGetAllChatEvent event, Emitter<ChatState> emit) async {
    try {
      final res = await _getAllChat(NoParams());
      res.fold((failure) => emit(ChatFailureState(failure: failure)), (schats) {

        chats = schats;
        emit(ChatRecievedState(chats: List.from(chats)));

      });
    } catch (e) {
      emit(ChatFailureState(failure: Failure(e.toString())));
    }
  }

  // FutureOr<void> _chatStartedListenEvent(
  //     ChatStartedListenEvent event, Emitter<ChatState> emit) {
  //   try {
  //     final res = _listenOnChat(NoParams());
  //     res.fold((failure) => emit(ChatFailureState(failure: failure)), (stream) {
  //       stream.listen((_) {
  //         add(ChatGetAllChatEvent());
  //       });
  //     });
  //   } catch (e) {
  //     emit(ChatFailureState(failure: Failure(e.toString())));
  //   }
  // }

  FutureOr<void> _chatStartedListenEvent(
      ChatStartedListenEvent event, Emitter<ChatState> emit) {
    try {
      final res = _listenOnChat(NoParams());

      res.fold((failure) => emit(ChatFailureState(failure: failure)),
          (chatstream) {
        chatstream.listen((chat) {
          add(ChatRecievedEvent(chat: chat));
        });
      });
    } catch (e) {
      emit(ChatFailureState(failure: Failure()));

    }
  }

  FutureOr<void> _chatRecievedEvent(
      ChatRecievedEvent event, Emitter<ChatState> emit) {
    chats.add(event.chat);
    emit(ChatRecievedState(chats: List.from(chats)));
  }
}
