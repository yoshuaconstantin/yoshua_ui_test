part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class onLoginButton extends LoginEvent{
  final String username;
  final String password;

  onLoginButton({required this.username,required this.password});
}
