import 'dart:async';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:aaa_chat_share/features/chat/data/models/chat_model.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepositoryImpl({
    required ChatRemoteDataSource chatRemoteDataSource,
  }) : _chatRemoteDataSource = chatRemoteDataSource;

  @override
  Future<Either<Failure, List<Chat>>> getAllChat() async {
    try {
      List<ChatModel> chatModels = await _chatRemoteDataSource.getAllChat();
      List<Chat> chats = chatModels.map<Chat>((chatModel) {
        return chatModel.toEntity();
      }).toList();
      return right(chats);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, bool>> sendChat(
  //     String message, String userId, DateTime time) async {
  //   try {
  //     return right(await _chatRemoteDataSource.sendChat(message, userId, time));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  @override
  Either<Failure, Stream<Chat>> listonOnChat() {
    try {
      return right(_chatRemoteDataSource.listonOnChat() as Stream<Chat>);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Either<Failure, void> sendChat(String message, String userId, DateTime time) {
    try {
      return right(_chatRemoteDataSource.sendChat(message, userId, time));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
