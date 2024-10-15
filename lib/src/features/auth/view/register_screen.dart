import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/features/auth/bloc/auth_bloc.dart';
import 'package:todo_app/src/features/auth/bloc/auth_event.dart';
import 'package:todo_app/src/features/auth/bloc/auth_state.dart';
import 'package:todo_app/src/features/auth/service/auth_repository.dart';
import 'package:todo_app/src/features/auth/view/login_screen.dart';
import 'package:todo_app/src/features/todo/view/todo_screen.dart';

import '../model/register_request_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  late bool passwordVisibility;
  late bool rePasswordVisibility;

  @override
  void initState() {
    super.initState();
    passwordVisibility = true;
    rePasswordVisibility = true;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
          ),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthRegisterSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    SizedBox(height: 80.sp),
                    Text(
                      'Register to log in',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                    SizedBox(height: 20.sp),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _fullNameController,
                            decoration: const InputDecoration(
                              label: Text('Full Name'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25.sp),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25.sp),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: passwordVisibility,
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.password),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25.sp),
                          TextFormField(
                            controller: _rePasswordController,
                            obscureText: rePasswordVisibility,
                            decoration: InputDecoration(
                              label: const Text('Confirm Password'),
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: rePasswordVisibility
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    rePasswordVisibility =
                                    !rePasswordVisibility;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.sp),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final registerRequest = RegisterRequest(
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    rePassword: _rePasswordController.text);
                                context.read<AuthBloc>().add(
                                  RegisterRequested(registerRequest),
                                );
                              }
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200.sp, 50.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
