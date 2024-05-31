import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user_entity.dart';
import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/auth_repository.dart';

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
