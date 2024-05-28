import 'dart:async';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListenChat implements UseCaseNoFuture<void, NoParams> {
  final ChatRepository _chatRepository;

  ListenChat({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Either<Failure, StreamController<Chat>> call(NoParams param) {
    return _chatRepository.listen();
  }
}
