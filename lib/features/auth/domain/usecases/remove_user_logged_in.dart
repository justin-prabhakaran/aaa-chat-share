import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/auth_repository.dart';

class RemoveUserLoggedIn implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  RemoveUserLoggedIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams param) async{
    return await _authRepository.removeUserData();
  }
}
