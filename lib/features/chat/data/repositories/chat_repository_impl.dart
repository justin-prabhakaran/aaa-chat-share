import 'dart:async';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/chat_remote_datasource.dart';
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
      return right(await _chatRemoteDataSource.getAllChat());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendChat(
      String message, String userId, DateTime time) async {
    try {
      return right(await _chatRemoteDataSource.sendChat(message, userId, time));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Either<Failure, Stream<void>> listonOnChat() {
    try {
      return right(_chatRemoteDataSource.listonOnChat());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
