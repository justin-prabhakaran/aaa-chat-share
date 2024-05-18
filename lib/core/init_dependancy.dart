import 'package:aaa_chat_share/features/auth/data/datasources/remote_data_resoure.dart';
import 'package:aaa_chat_share/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/create_user.dart';
import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final serverLocator = GetIt.instance;

void initDepends() {
  serverLocator
    ..registerLazySingleton(
      () => AuthBloc(
        createUser: serverLocator(),
      ),
    )
    ..registerFactory(
      () => CreateUser(
        authRepository: serverLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serverLocator(),
      ),
    )
    ..registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImp(),
    );
}
