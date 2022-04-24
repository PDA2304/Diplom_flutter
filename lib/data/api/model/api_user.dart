import 'package:passmanager_diplom/data/api/model/api_validation_auth.dart';

class ApiUser {
  final int? id;
  final String? userName;
  final String? email;
  final ApiValidationAuth validAuth;

  ApiUser.fromApi(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        userName = json['user_name'] ?? '',
        email = json['login'] ?? '',
        validAuth = ApiValidationAuth.fromApi(
          json['error'] ??
              {
                'login': null,
                'user_name': null,
                'password': null,
              },
        );
}
