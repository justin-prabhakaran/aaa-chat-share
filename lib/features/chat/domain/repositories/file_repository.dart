import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FileRepository {
  Future<Either<Failure, List<File>>> getAllFiles();
  Future<Either<Failure, bool>> upladFile();
}
