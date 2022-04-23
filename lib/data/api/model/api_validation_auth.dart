class ApiValidationAuth {
  final List<dynamic>? userName;
  final List<dynamic>? login;
  final List<dynamic>? password;

  ApiValidationAuth.fromApi(Map<String, dynamic> json)
      : userName = json['user_name'] ?? <dynamic>[],
        login = json['login'] ?? <dynamic>[],
        password = json['password'] ?? <dynamic>[];
}
