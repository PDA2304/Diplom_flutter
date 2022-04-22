class ApiValidationAuth {
  final List<dynamic>? userName;
  final List<dynamic>? login;
  final List<dynamic>? password;

  ApiValidationAuth.fromApi(Map<String, dynamic> json)
      : userName = json['error']['user_name'] ?? <String>[],
        login = json['error']['login'] ?? <String>[],
        password = json['error']['password'] ?? <String>[];
}
