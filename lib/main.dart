import 'package:aaa_chat_share/core/init_dependancy.dart';
import 'package:aaa_chat_share/core/theme.dart';
import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aaa_chat_share/features/auth/presentation/pages/auth_page.dart';
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
    return BlocProvider(
      create: (BuildContext context) => serverLocator<AuthBloc>(),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColor.dark),
        home: AuthPage(),
      ),
    );
  }
}