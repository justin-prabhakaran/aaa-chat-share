import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SaveUserLoggedIn implements UseCase<void, SaveUserLoggedInParams> {
  final AuthRepository _authRepository;

  SaveUserLoggedIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(SaveUserLoggedInParams param) async {
    return await _authRepository.storeUserData(param.userId);
  }
}

class SaveUserLoggedInParams {
  final String userId;

  const SaveUserLoggedInParams({required this.userId});
}
