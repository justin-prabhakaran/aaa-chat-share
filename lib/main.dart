import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/cubit/app_auth_cubit.dart';
import 'core/init_dependancy.dart';
import 'core/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'features/chat/presentation/pages/chat_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  initDepends();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppAuthCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FileBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ChatBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColor.dark),
        home: BlocBuilder<AppAuthCubit, AppAuthState>(
          builder: (context, state) {
            if (state is AppAuthLoggedInState) {
              return const ChatPage();
            } else if (state is AppAuthInitial) {
              return AuthPage();
            }
            return AuthPage();
          },
        ));
  }
}
