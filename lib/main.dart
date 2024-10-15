import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/features/auth/bloc/auth_bloc.dart';
import 'package:todo_app/src/features/auth/service/auth_repository.dart';
import 'package:todo_app/src/features/auth/view/login_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => AuthBloc(
              authRepository: AuthRepository(),
            )),
  ], child: const MyApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color.fromARGB(1, 28, 36, 49),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(1, 28, 36, 49),
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(),
          ),
          home: child,
        );
      },
      child: const LoginScreen(),
    );
  }
}
