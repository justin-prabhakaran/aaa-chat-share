import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> createUser(String userName);
}
