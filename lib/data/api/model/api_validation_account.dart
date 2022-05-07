class ApiValidationAccount {
  final List<dynamic> accountName;
  final List<dynamic> login;
  final List<dynamic> password;

  ApiValidationAccount.fromApi(Map<String, dynamic> json)
      : accountName = json['account_name'] ?? <dynamic>[],
        login = json['login'] ?? <dynamic>[],
        password = json['password'] ?? <dynamic>[];
}
