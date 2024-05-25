import 'package:aaa_chat_share/core/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_auth_state.dart';

class AppAuthCubit extends Cubit<AppAuthState> {
  AppAuthCubit() : super(AppAuthInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppAuthInitial());
    } else {
      emit(
        AppAuthLoggedInState(user: user),
      );
    }
  }
}
