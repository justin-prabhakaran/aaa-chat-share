import 'dart:typed_data';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/remote_file_datasource.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/file_repository.dart';
import 'package:fpdart/fpdart.dart';

class FileRepositoryImpl implements FileRepository {
  final RemoteFileDataSource _remoteFileDataSource;

  FileRepositoryImpl({required RemoteFileDataSource remoteFileDataSource})
      : _remoteFileDataSource = remoteFileDataSource;

  @override
  Future<Either<Failure, List<File>>> getAllFiles() async {
    try {
      final res = await _remoteFileDataSource.getAllFiles();
      return right(res as List<File>);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> upladFile(
      Uint8List file, String userId, String fileName) async {
    try {
      return right(
          await _remoteFileDataSource.upladFile(file, userId, fileName));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
