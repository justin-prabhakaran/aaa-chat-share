import 'dart:typed_data';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/file_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadFile implements UseCase<bool, UploadFileParams> {
  final FileRepository _fileRepository;

  UploadFile({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  @override
  Future<Either<Failure, bool>> call(UploadFileParams param) async {
    return await _fileRepository.upladFile(
        param.file, param.userId, param.fileName);
  }
}

class UploadFileParams {
  final String userId;
  final Uint8List file;
  final String fileName;
  UploadFileParams(
      {required this.userId, required this.file, required this.fileName});
}
