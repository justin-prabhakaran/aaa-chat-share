part of 'app_auth_cubit.dart';

sealed class AppAuthState extends Equatable {
  const AppAuthState();

  @override
  List<Object> get props => [];
}

final class AppAuthInitial extends AppAuthState {}

class AppAuthLoggedInState extends AppAuthState {
  final User user;
  const AppAuthLoggedInState({required this.user});
}
