import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/auth/data/datasources/remote_data_resoure.dart';
import 'package:aaa_chat_share/features/auth/data/models/user_model.dart';
import 'package:aaa_chat_share/core/entities/user_entity.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({required RemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, User>> createUser(String userName) async {
    try {
      final res = await _remoteDataSource.createUser(userName);
      final user = UserModle.fromMap(res);
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> isUserLoggedIn() async {
    try {
      final res = await _remoteDataSource.isUserLoggedIn();
      if (res.isNotEmpty) {
        print(UserModle.fromMap(res));
        return right(UserModle.fromMap(res));
      }
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeUserData() async {
    try {
      final res = await _remoteDataSource.removeUserLoggedIn();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storeUserData(String userId) async {
    try {
      final res = await _remoteDataSource.saveUserLoggedIn(userId);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
