import 'package:passmanager_diplom/data/api/model/api_validation_account.dart';

class ApiAccount {
  final int? id;
  final String? accountName;
  final String? login;
  final String? password;
  final String? description;
  final String? createAt;
  final bool? isCreator;
  final int? userId;
  final ApiValidationAccount? validAccount;

  ApiAccount.fromApi(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        accountName = json['account_name'] ?? '',
        login = json['login'] ?? '',
        password = json['password'] ?? '',
        description = json['description'] ?? '',
        createAt = json['created_at'] ?? DateTime.now().toIso8601String(),
        isCreator = json['creator'] ?? true,
        userId = json['user_id'] ?? 0,
        validAccount = json['error'] == null
            ? null
            : ApiValidationAccount.fromApi(json['error']);
}
