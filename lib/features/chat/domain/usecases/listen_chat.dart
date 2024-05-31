import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListenOnChat implements UseCaseNoFuture<Stream<Chat>, NoParams> {
  final ChatRepository _chatRepository;
  ListenOnChat({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Either<Failure, Stream<Chat>> call(NoParams param) {
    return _chatRepository.listonOnChat();
  }
}
