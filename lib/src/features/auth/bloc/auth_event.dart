import 'package:equatable/equatable.dart';

import '../model/login_request_model.dart';
import '../model/register_request_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final LoginRequest loginRequest;

  const LoginRequested(this.loginRequest);

  @override
  List<Object?> get props => [loginRequest];
}

class RegisterRequested extends AuthEvent {
  final RegisterRequest registerRequest;

  const RegisterRequested(this.registerRequest);

  @override
  List<Object?> get props => [registerRequest];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
  @override
  List<Object?> get props => [];
}