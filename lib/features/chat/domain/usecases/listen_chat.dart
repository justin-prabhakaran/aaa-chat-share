import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class ListenOnChat implements UseCaseNoFuture<Stream<Chat>, NoParams> {
  final ChatRepository _chatRepository;
  ListenOnChat({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Either<Failure, Stream<Chat>> call(NoParams param) {
    return _chatRepository.listonOnChat();

  }
}
