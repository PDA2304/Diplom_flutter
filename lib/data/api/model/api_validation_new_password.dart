class ApiValidationNewPassword {
  final List<dynamic>? newPassword;
  final List<dynamic>? oldPassword;

  ApiValidationNewPassword.fromApi(Map<String, dynamic> json)
      : newPassword = json  ['new_password'] ?? <dynamic>[],
        oldPassword = json['old_password'] ?? <dynamic>[];
}
