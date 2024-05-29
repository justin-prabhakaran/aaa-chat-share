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
  Either<Failure, StreamController<Chat>> listen() {
    try {
      return right(
        _chatRemoteDataSource.listen(),
      );
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Either<Failure, void> sendChat(
      String message, DateTime time, String userName) {
    try {
      _chatRemoteDataSource.sendChat(message, userName, time);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

}
