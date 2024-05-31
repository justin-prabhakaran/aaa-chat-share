import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../entities/file.dart';
import '../repositories/file_repository.dart';

class GetAllFiles implements UseCase<List<File>, NoParams> {
  final FileRepository _fileRepository;

  GetAllFiles({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  @override
  Future<Either<Failure, List<File>>> call(NoParams param) async {
    return await _fileRepository.getAllFiles();
  }
}
