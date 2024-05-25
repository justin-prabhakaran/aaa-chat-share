import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/core/entities/user_entity.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateUser implements UseCase<User, CreateUserParam> {
  final AuthRepository _authRepository;

  CreateUser({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(CreateUserParam param) async {
    return await _authRepository.createUser(param.userName);
  }
}

class CreateUserParam {
  String userName;
  CreateUserParam(this.userName);
}
