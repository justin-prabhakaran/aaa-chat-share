import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/file_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllFiles implements UseCase<List<File>, NoParams> {
  final FileRepository _fileRepository;

  GetAllFiles({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  @override
  Future<Either<Failure, List<File>>> call(NoParams param) async {
    return await _fileRepository.getAllFiles();
  }
}
