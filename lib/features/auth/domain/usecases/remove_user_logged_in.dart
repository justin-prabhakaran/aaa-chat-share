import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveUserLoggedIn implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  RemoveUserLoggedIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams param) async{
    return await _authRepository.removeUserData();
  }
}
