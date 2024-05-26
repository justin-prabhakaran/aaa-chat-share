import 'package:aaa_chat_share/core/cubit/app_auth_cubit.dart';
import 'package:aaa_chat_share/features/auth/data/datasources/remote_data_resoure.dart';
import 'package:aaa_chat_share/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/create_user.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/is_user_logged_in.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/save_user_logged_in.dart';
import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/file_remote_datasource.dart';
import 'package:aaa_chat_share/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:aaa_chat_share/features/chat/data/repositories/file_repository_impl.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/chat_repository.dart';
import 'package:aaa_chat_share/features/chat/domain/repositories/file_repository.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/get_all_files.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/listen_chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/listen_files.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/send_chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/upload_file.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initDepends() {
  serviceLocator
    //Auth Use Cases
    ..registerFactory(
      () => SaveUserLoggedIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsUserLoggedIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CreateUser(
        authRepository: serviceLocator(),
      ),
    )

    //Auth Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImp(),
    )

    //File Use Cases
    ..registerFactory(
      () => GetAllFiles(
        fileRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadFile(
        fileRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ListenOnFiles(
        fileRepository: serviceLocator(),
      ),
    )

    //File Repositories
    ..registerFactory<FileRepository>(
      () => FileRepositoryImpl(
        remoteFileDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<FileRemoteDataSource>(
      () => FileRemoteDataSourceImpl(),
    )

    //Chat Use Cases
    ..registerFactory(
      () => SendChat(
        chatRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ListenChat(
        chatRepository: serviceLocator(),
      ),
    )

    //Chat Repositories
    ..registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(
        chatRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(),
    )

    //Blocs
    ..registerLazySingleton(
      () => AuthBloc(
        createUser: serviceLocator(),
        appAuthCubit: serviceLocator(),
        isUserLoggedIn: serviceLocator(),
        saveUserLoggedIn: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FileBloc(
        getAllFiles: serviceLocator(),
        upladFile: serviceLocator(),
        listenOnFiles: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ChatBloc(
        sendChat: serviceLocator(),
        listenChat: serviceLocator(),
      ),
    )

    //Cubit
    ..registerLazySingleton(
      () => AppAuthCubit(),
    );
}
