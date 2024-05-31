import '../../../../core/entities/user_entity.dart';
import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/auth_repository.dart';
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
