import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

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
