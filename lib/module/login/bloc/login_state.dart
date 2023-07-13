part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class onLoginLoading extends LoginState {}

class onLoginSuccess extends LoginState {
  final LoginResponse data;

  onLoginSuccess({required this.data});
}

class onLoginFailed extends LoginState {
  final String message;

  onLoginFailed({required this.message});
}

class onLoginFinished extends LoginState {}
