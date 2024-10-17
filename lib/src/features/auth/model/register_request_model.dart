class RegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final String rePassword;


  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.rePassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'rePassword': rePassword,
    };
  }
}
