
import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/features/auth/domain/entities/user_entity.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/create_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser _createUser;

  AuthBloc({required CreateUser createUser})
      : _createUser = createUser,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoadingState());
    });

    on<AuthCreateUserEvent>(_createUserBloc);
  }

  _createUserBloc(AuthCreateUserEvent event, Emitter<AuthState> emit) async {
    final res = await _createUser(CreateUserParam(event.userName));

    res.fold(
      (failure) => emit(
        AuthFailureState(
          failure: Failure(failure.message),
        ),
      ),
      (user) => emit(
        AuthSuccessState(user: user),
      ),
    );
  }
}
