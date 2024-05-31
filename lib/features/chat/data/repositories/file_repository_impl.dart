import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../domain/entities/file.dart';
import '../../domain/repositories/file_repository.dart';
import '../datasources/file_remote_datasource.dart';

class FileRepositoryImpl implements FileRepository {
  final FileRemoteDataSource _remoteFileDataSource;

  FileRepositoryImpl({required FileRemoteDataSource remoteFileDataSource})
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

  @override
  Either<Failure, Stream<void>> listenOnFiles() {
    try {
      return right(_remoteFileDataSource.listenOnFiles());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
