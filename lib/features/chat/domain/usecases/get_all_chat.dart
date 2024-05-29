import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllChat implements UseCase<List<Chat>, NoParams> {
  final ChatRepository _chatRepository;

  GetAllChat({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;
  @override
  Future<Either<Failure, List<Chat>>> call(NoParams param) async{
    return await _chatRepository.getAllChat();
  }
}
