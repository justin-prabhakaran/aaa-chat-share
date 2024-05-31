import 'package:fpdart/fpdart.dart';

import 'failure.dart';

abstract interface class UseCase<SuccessType, Param> {
  Future<Either<Failure, SuccessType>> call(Param param);
}

abstract interface class UseCaseNoFuture<SuccessType, Param> {
  Either<Failure, SuccessType> call(Param param);
}

class NoParams {}
