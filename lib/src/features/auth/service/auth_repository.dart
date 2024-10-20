import 'dart:convert';

import 'package:todo_app/src/features/auth/model/login_model.dart';
import 'package:todo_app/src/features/auth/model/login_request_model.dart';
import 'package:todo_app/src/features/auth/model/register_model.dart';
import 'package:todo_app/src/features/auth/model/register_request_model.dart';
import 'package:todo_app/src/features/auth/service/auth_service.dart';
import 'package:http/http.dart' as http;

class AuthRepository extends AuthService {
  final registerApiUrl = 'https://10.0.2.2:7261/api/Auth/register';
  final loginApiUrl = 'https://10.0.2.2:7261/api/Auth/login';

  @override
  Future<LoginModel> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse(loginApiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return LoginModel.fromJson(responseData);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<RegisterModel> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse(registerApiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return RegisterModel.fromJson(responseData);
    } else {
      throw Exception('Failed to register');
    }
  }

  //https://localhost:7261/api/ToDo/addToDo
}
