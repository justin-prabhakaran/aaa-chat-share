import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendChat implements UseCase<bool, SendChatParams> {
  final ChatRepository _chatRepository;

  SendChat({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, bool>> call(SendChatParams param) async {
    return await _chatRepository.sendChat(
        param.message, param.userId, param.time);
  }
}

class SendChatParams {
  String message;
  String userId;
  DateTime time;

  SendChatParams(
      {required this.message, required this.userId, required this.time});
}
