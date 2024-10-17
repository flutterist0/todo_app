class LoginModel {
  final String token;
  final String expiration;
  final int userId;

  LoginModel({
    required this.token,
    required this.expiration,
    required this.userId
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      expiration: json['expiration'],
      userId: json['userId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiration': expiration,
      'userId':userId,
    };
  }
}
