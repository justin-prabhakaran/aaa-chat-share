part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCreateUserEvent extends AuthEvent {
  final String userName;
  const AuthCreateUserEvent({required this.userName});
}

class AuthIsUserLoggedIn extends AuthEvent {}
