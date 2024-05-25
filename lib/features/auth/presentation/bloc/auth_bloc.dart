import 'package:aaa_chat_share/core/cubit/app_auth_cubit.dart';
import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/entities/user_entity.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/create_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser _createUser;
  final AppAuthCubit _appAuthCubit;
  AuthBloc({required CreateUser createUser, required AppAuthCubit appAuthCubit})
      : _createUser = createUser,
        _appAuthCubit = appAuthCubit,
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
            ), (user) {
      _appAuthCubit.updateUser(user);
      emit(
        AuthSuccessState(user: user),
      );
    });
  }
}
