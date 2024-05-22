import 'package:aaa_chat_share/features/auth/data/datasources/remote_data_resoure.dart';
import 'package:aaa_chat_share/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aaa_chat_share/features/auth/domain/repositories/auth_repository.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/create_user.dart';
import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:aaa_chat_share/features/chat/data/datasources/remote_file_datasource.dart';
import 'package:aaa_chat_share/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:aaa_chat_share/features/chat/data/repositories/file_repository_impl.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/get_all_files.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/listen_chat.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/send_chat.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initDepends() {
  serviceLocator

    //Auth
    ..registerLazySingleton(
      () => AuthBloc(
        createUser: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CreateUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImp(),
    )

    //File
    ..registerLazySingleton(
      () => FileBloc(
        getAllFiles: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllFiles(
        fileRepository: serviceLocator<FileRepositoryImpl>(),
      ),
    )
    ..registerFactory(
      () => FileRepositoryImpl(
        remoteFileDataSource: serviceLocator<RemoteFileDataSourceImpl>(),
      ),
    )
    ..registerFactory(
      () => RemoteFileDataSourceImpl(),
    )

    //Chat
    ..registerLazySingleton(
      () => ChatBloc(
        sendChat: serviceLocator(),
        listenChat: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SendChat(
        chatRepository: serviceLocator<ChatRepositoryImpl>(),
      ),
    )
    ..registerFactory(
      () => ListenChat(
        chatRepository: serviceLocator<ChatRepositoryImpl>(),
      ),
    )
    ..registerFactory(
      () => ChatRepositoryImpl(
        chatRemoteDataSource: serviceLocator<ChatRemoteDataSourceImpl>(),
      ),
    )
    ..registerLazySingleton(
      () => ChatRemoteDataSourceImpl(),
    );
}
