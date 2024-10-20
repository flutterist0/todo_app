import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/features/auth/bloc/auth_bloc.dart';
import 'package:todo_app/src/features/auth/bloc/auth_event.dart';
import 'package:todo_app/src/features/auth/bloc/auth_state.dart';
import 'package:todo_app/src/features/auth/model/login_request_model.dart';
import 'package:todo_app/src/features/auth/service/auth_repository.dart';
import 'package:todo_app/src/features/auth/view/register_screen.dart';
import 'package:todo_app/src/features/todo/view/todo_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool passwordVisibility;

  @override
  void initState() {
    super.initState();
    passwordVisibility = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => ToDoScreen(),
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            print(state.error);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80.sp),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.sp),
                Text(
                  'Please sign in',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(height: 20.sp),
                buildLoginForm(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailTextfield(),
          SizedBox(height: 25.sp),
          buildPassworTextField(),
          buildRowSignUp(context),
          SizedBox(height: 20.sp),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return buildAuthLoading();
              }

              return buildElevetedButton(context);
            },
          )
        ],
      ),
    );
  }

  ElevatedButton buildElevetedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final loginRequest = LoginRequest(
            email: _emailController.text,
            password: _passwordController.text,
          );

          context.read<AuthBloc>().add(
                LoginRequested(loginRequest),
              );
        }
      },
      child: Text(
        'Log in',
        style: TextStyle(fontSize: 15.sp),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(200.sp, 50.sp),
      ),
    );
  }

  CircularProgressIndicator buildAuthLoading() => CircularProgressIndicator();

  Row buildRowSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Not a member yet?',
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => RegisterScreen(),
              ),
            );
          },
          child: const Text('Sign up'),
        )
      ],
    );
  }

  TextFormField buildPassworTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: passwordVisibility,
      decoration: InputDecoration(
        label: const Text(
          'Password',
          style: TextStyle(color: Colors.white),
        ),
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(
          Icons.password,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: passwordVisibility
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailTextfield() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        label: Text(
          'Email',
          style: TextStyle(color: Colors.white),
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
      ),
    );
  }
}
