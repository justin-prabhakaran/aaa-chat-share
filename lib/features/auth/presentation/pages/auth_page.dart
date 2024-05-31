import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/snack_bar.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_success_page_widget.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  static get router => MaterialPageRoute(builder: (context) => AuthPage());
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
            Navigator.pushAndRemoveUntil(
                context, ChatPage.router, (router) => false);
          } else if (state is AuthFailureState) {
            showSnackBar(context, state.failure.message);
          }
        },
      ),
    );
  }
}
