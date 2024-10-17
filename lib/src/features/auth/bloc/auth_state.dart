import 'package:equatable/equatable.dart';

import '../model/login_model.dart';
import '../model/register_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final LoginModel loginModel;

  const AuthLoginSuccess(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class AuthRegisterSuccess extends AuthState {
  final RegisterModel registerModel;

  const AuthRegisterSuccess(this.registerModel);

  @override
  List<Object?> get props => [registerModel];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}