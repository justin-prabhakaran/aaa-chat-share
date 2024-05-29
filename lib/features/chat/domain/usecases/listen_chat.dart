import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ListenOnChat implements UseCaseNoFuture<Stream<void>, NoParams> {
  final ChatRepository _chatRepository;
  ListenOnChat({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Either<Failure, Stream<void>> call(NoParams param)  {
    return  _chatRepository.listonOnChat();
  }
}
