import 'package:passmanager_diplom/data/api/model/api_validation_new_login.dart';

class ApiConfirmationNewLogin {
  final int number;
  final ApiValidationNewLogin? validationNewLogin;

  ApiConfirmationNewLogin.fromApi(Map<String, dynamic> json)
      : number = json['number'] ?? 0,
        validationNewLogin =
            ApiValidationNewLogin.fromApi(json['error'] ?? {'login': null});
}
