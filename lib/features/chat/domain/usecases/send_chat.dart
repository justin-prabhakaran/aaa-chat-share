import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendChat implements UseCaseNoFuture<void, ChatSendParams> {
  final ChatRepository _chatRepository;

  SendChat({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Either<Failure, void> call(ChatSendParams param) {
    return _chatRepository.sendChat(param.message, param.time, param.userName);
  }
}

class ChatSendParams {
  String message;
  String userName;
  DateTime time;
  bool isMe;
  ChatSendParams({
    required this.message,
    required this.userName,
    required this.time,
    this.isMe = false,
  });
}
