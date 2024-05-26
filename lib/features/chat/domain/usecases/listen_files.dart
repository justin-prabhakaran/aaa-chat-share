import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/file_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListenOnFiles implements UseCaseNoFuture<Stream<void>, NoParams> {
  final FileRepository _fileRepository;
  ListenOnFiles({required FileRepository fileRepository})
      : _fileRepository = fileRepository;
  @override
  Either<Failure, Stream<void>> call(NoParams param) {
    return _fileRepository.listenOnFiles();
  }
}
