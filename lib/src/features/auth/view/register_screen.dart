import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  late bool passwordVisibilty;
  late bool rePasswordVisibility;
  @override
  void initState() {
    super.initState();
    passwordVisibilty = true;
    rePasswordVisibility = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80.sp,
              ),
              Text(
                'Register to log in',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Full Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.sp,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 25.sp,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: passwordVisibilty,
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
                          icon: passwordVisibilty
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisibilty = !passwordVisibilty;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.sp,
                    ),
                    TextFormField(
                      controller: _rePasswordController,
                      obscureText: rePasswordVisibility,
                      decoration: InputDecoration(
                        label: const Text(
                          'Confirm Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: rePasswordVisibility
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              rePasswordVisibility = !rePasswordVisibility;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
