import 'package:aaa_chat_share/core/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Param> {
  Future<Either<Failure, SuccessType>> call(Param param);
}

class NoParams {}
