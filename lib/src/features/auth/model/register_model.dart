class RegisterModel {
/*
{
  "token": "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjQiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoic3RyaW5nIHN0cmluZyIsImVtYWlsIjoic3RyaW5nIiwibmJmIjoxNzI1OTk4MzQyLCJleHAiOjE3MjYwMDE5NDIsImlzcyI6ImVsbWlyIiwiYXVkIjoiRWxtaXJNaWtheWlsbGkifQ.nMYBCxAAv4C3wQ0ekOfSuZuBhuV8B1sOXuiZHvgzkdKSEG5MG2qZC8EECllkQmeQ3vY1De2ZvRJ5gh7BmqsqYQ",
  "expiration": "2024-09-11T00:59:02.673776+04:00"
}
*/

  final String token;
  final String expiration;
  final int userId;
  RegisterModel({
    required this.token,
    required this.expiration,
    required this.userId,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      token: json['token'],
      expiration: json['expiration'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiration': expiration,
      'userId': userId,
    };
  }
}
