import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/chat_repository.dart';

class SendChat implements UseCaseNoFuture<void, SendChatParams> {
  final ChatRepository _chatRepository;

  SendChat({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Either<Failure, void> call(SendChatParams param) {
    return _chatRepository.sendChat(param.message, param.userId, param.time);
  }
}

class SendChatParams {
  String message;
  String userId;
  DateTime time;
  SendChatParams(
      {required this.message, required this.userId, required this.time});
}
