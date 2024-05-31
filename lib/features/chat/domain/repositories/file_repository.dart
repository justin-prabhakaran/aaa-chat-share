import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../entities/file.dart';

abstract interface class FileRepository {
  Future<Either<Failure, List<File>>> getAllFiles();
  Future<Either<Failure, bool>> upladFile(
      Uint8List file, String userId, String fileName);

  Either<Failure, Stream<void>> listenOnFiles();
}
