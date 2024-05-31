import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user_entity.dart';
import '../../../../core/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> createUser(String userName);
  Future<Either<Failure, User?>> isUserLoggedIn();
  Future<Either<Failure, void>> storeUserData(String userId);
  Future<Either<Failure, void>> removeUserData();
}
