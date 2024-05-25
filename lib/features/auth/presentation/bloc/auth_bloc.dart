import 'package:aaa_chat_share/core/cubit/app_auth_cubit.dart';
import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/create_user.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/is_user_logged_in.dart';
import 'package:aaa_chat_share/features/auth/domain/usecases/save_user_logged_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser _createUser;
  final AppAuthCubit _appAuthCubit;
  final IsUserLoggedIn _isUserLoggedIn;
  final SaveUserLoggedIn _saveUserLoggedIn;
  AuthBloc(
      {required CreateUser createUser,
      required AppAuthCubit appAuthCubit,
      required IsUserLoggedIn isUserLoggedIn,
      required SaveUserLoggedIn saveUserLoggedIn})
      : _createUser = createUser,
        _appAuthCubit = appAuthCubit,
        _isUserLoggedIn = isUserLoggedIn,
        _saveUserLoggedIn = saveUserLoggedIn,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoadingState());
    });

    on<AuthCreateUserEvent>(_createUserBloc);
    on<AuthIsUserLoggedIn>(_isUserLoggedInBloc);
  }

  _createUserBloc(AuthCreateUserEvent event, Emitter<AuthState> emit) async {
    final res = await _createUser(CreateUserParam(event.userName));

    res.fold(
        (failure) => emit(AuthFailureState(failure: Failure(failure.message))),
        (user) async {
      final inres =
          await _saveUserLoggedIn(SaveUserLoggedInParams(userId: user.userId));

      inres.fold((failure) => emit(AuthFailureState(failure: failure)), (_) {
        _appAuthCubit.updateUser(user);
        emit(AuthSuccessState());
      });
    });
  }

  _isUserLoggedInBloc(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _isUserLoggedIn(NoParams());

    res.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (user) {
        if (user != null) {
          _appAuthCubit.updateUser(user);
          emit(AuthSuccessState());
        } else {
          emit(AuthFailureState(failure: Failure('User is not logged in')));
          emit(AuthInitial());
        }
      },
    );
  }
}
