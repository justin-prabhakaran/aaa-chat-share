import 'package:aaa_chat_share/core/init_dependancy.dart';
import 'package:aaa_chat_share/core/theme.dart';
import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aaa_chat_share/features/auth/presentation/pages/auth_page.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initDepends();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<FileBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ChatBloc>(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColor.dark),
        home: AuthPage(),
      ),
    );
  }
}
