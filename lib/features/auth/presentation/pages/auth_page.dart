import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aaa_chat_share/features/auth/presentation/widgets/auth_success_page_widget.dart';
import 'package:aaa_chat_share/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  static router() => MaterialPageRoute(builder: (context) => AuthPage());
  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AuthSuccessWidget(
              textEditingController: _textEditingController);
        },
        listener: (BuildContext context, state) {
          if (state is AuthSuccessState) {
            Navigator.push(context, ChatPage.router());
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
        },
      ),
    );
  }
}
