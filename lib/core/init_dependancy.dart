
import 'cubit/app_auth_cubit.dart';
import '../features/auth/data/datasources/remote_data_resoure.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/create_user.dart';
import '../features/auth/domain/usecases/is_user_logged_in.dart';
import '../features/auth/domain/usecases/save_user_logged_in.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/chat/data/datasources/chat_remote_datasource.dart';
import '../features/chat/data/datasources/file_remote_datasource.dart';
import '../features/chat/data/repositories/chat_repository_impl.dart';
import '../features/chat/data/repositories/file_repository_impl.dart';
import '../features/chat/domain/repositories/chat_repository.dart';
import '../features/chat/domain/repositories/file_repository.dart';
import '../features/chat/domain/usecases/get_all_chat.dart';
import '../features/chat/domain/usecases/get_all_files.dart';
import '../features/chat/domain/usecases/listen_chat.dart';
import '../features/chat/domain/usecases/listen_files.dart';
import '../features/chat/domain/usecases/send_chat.dart';
import '../features/chat/domain/usecases/upload_file.dart';
import '../features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
      () => FileRemoteDataSourceImpl(
        socket: serviceLocator(),
      ),
    )

    //Chat Use Cases
    ..registerFactory(
      () => SendChat(
        chatRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ListenOnChat(
        chatRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllChat(
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
      () => ChatRemoteDataSourceImpl(
        socket: serviceLocator(),
      ),
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
        listenOnChat: serviceLocator(),
        getAllChat: serviceLocator(),
      ),
    )

    //Cubit
    ..registerLazySingleton(
      () => AppAuthCubit(),
    )

    //Addons
    ..registerLazySingleton<Socket>(
      () => io(
        'http://localhost:1234',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build(),
      ),
    );
}
