import 'dart:typed_data';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart' as AAA;
import 'package:fpdart/fpdart.dart';

abstract interface class FileRepository {
  Future<Either<Failure, List<AAA.File>>> getAllFiles();
  Future<Either<Failure, bool>> upladFile(
      Uint8List file, String userId, String fileName);
}
