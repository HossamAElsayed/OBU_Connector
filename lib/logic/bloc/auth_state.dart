part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final User user;

  const AuthState(this.user);
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial(User user) : super(user);
}

class AuthLoggedIn extends AuthState {
  const AuthLoggedIn(User user) : super(user);
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut(User user) : super(user);
}

class AuthError extends AuthState {
  const AuthError(User user) : super(user);
}
