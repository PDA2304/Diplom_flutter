class ApiValidationNewUserName {
  final List<dynamic>? userName;

  ApiValidationNewUserName.fromApi(Map<String, dynamic> json)
      : userName = json['user_name'] ?? <dynamic>[];
}
