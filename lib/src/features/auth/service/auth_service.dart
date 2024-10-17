import 'package:todo_app/src/features/auth/model/register_request_model.dart';

import '../model/login_model.dart';
import '../model/login_request_model.dart';
import '../model/register_model.dart';

abstract class AuthService{
  Future<RegisterModel> register(RegisterRequest request);
  Future<LoginModel> login(LoginRequest request);
}