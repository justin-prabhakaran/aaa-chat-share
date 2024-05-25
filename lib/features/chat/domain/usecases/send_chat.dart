import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendChat implements UseCaseNoFuture<void, SendChatParams> {
  final ChatRepository _chatRepository;

  SendChat({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Either<Failure, void> call(SendChatParams param) {
    return _chatRepository.sendChat(param.message, param.time, param.userName);
  }
}

class SendChatParams {
  String message;
  String userName;
  DateTime time;
  bool isMe;
  SendChatParams({
    required this.message,
    required this.userName,
    required this.time,
    this.isMe = false,
  });
}
