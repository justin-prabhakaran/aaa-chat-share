import 'dart:async';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, bool>> sendChat(
      String message, String userId, DateTime time);
  Future<Either<Failure, List<Chat>>> getAllChat();
  Either<Failure, Stream<void>> listonOnChat();
}
