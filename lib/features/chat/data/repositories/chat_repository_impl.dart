import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_model.dart';

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
