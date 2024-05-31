import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/file_repository.dart';

class ListenOnFiles implements UseCaseNoFuture<Stream<void>, NoParams> {
  final FileRepository _fileRepository;
  ListenOnFiles({required FileRepository fileRepository})
      : _fileRepository = fileRepository;
  @override
  Either<Failure, Stream<void>> call(NoParams param) {
    return _fileRepository.listenOnFiles();
  }
}
