import 'package:aaa_chat_share/core/entities/user_entity.dart';
import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class IsUserLoggedIn implements UseCase<User?, NoParams> {
  final AuthRepository _authRepository;

  IsUserLoggedIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User?>> call(NoParams param) async {
    return await _authRepository.isUserLoggedIn();
  }
}
