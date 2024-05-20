import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChatRepository {
  Either<Failure, Stream<Chat>> listen();
  Either<Failure, void> sendChat(
      String message, DateTime time, String userName);
}
