part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStatus extends AuthEvent {}

class AuthLogIn extends AuthEvent {
  final String userName;
  final String password;
  const AuthLogIn(this.userName, this.password);
  @override
  List<Object> get props => [userName, password];
}

class AuthLogOut extends AuthEvent {}
