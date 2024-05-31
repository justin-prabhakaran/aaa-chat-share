import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../entities/chat.dart';

abstract interface class ChatRepository {
  Either<Failure, void> sendChat(String message, String userId, DateTime time);
  Future<Either<Failure, List<Chat>>> getAllChat();
  Either<Failure, Stream<Chat>> listonOnChat();
}
