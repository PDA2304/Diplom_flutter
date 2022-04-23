import 'package:passmanager_diplom/data/api/model/api_validation_auth.dart';

class ApiConfirmation {
  final int? number;
  final ApiValidationAuth? validatioAuth;

  ApiConfirmation.fromApi(Map<String, dynamic> json)
      : number = json['number'] ?? 0,
        validatioAuth = ApiValidationAuth.fromApi(
          json['error'] ??
              {
                'login': null,
                'user_name': null,
                'password': null,
              },
        );
}
