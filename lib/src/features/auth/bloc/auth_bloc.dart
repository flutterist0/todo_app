import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/src/features/auth/bloc/auth_event.dart';
import 'package:todo_app/src/features/auth/bloc/auth_state.dart';
import 'package:todo_app/src/features/auth/service/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final box = GetStorage();
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final loginModel = await authRepository.login(event.loginRequest);
        box.write('token', loginModel.token);
        emit(AuthLoginSuccess(loginModel));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final registerModel = await authRepository.register(event.registerRequest);
        emit(AuthRegisterSuccess(registerModel));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        box.remove('token');
        print('token silindi');

        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure('Failed to logout'));
      }
    });
  }
}
