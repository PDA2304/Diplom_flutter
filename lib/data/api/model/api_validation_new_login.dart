class ApiValidationNewLogin {
  final List<dynamic>? login;

  ApiValidationNewLogin.fromApi(Map<String, dynamic> json)
      : login = json['login'] ?? <dynamic>[];
}
