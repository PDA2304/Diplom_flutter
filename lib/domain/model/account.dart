import 'package:passmanager_diplom/domain/model/validation_account.dart';

class Account {
  final int id;
  final String accountName;
  final String login;
  final String password;
  final String description;
  final DateTime createAt;
  final bool isCreator;
  final int userId;
  final ValidationAccount? validationAccount;

  Account({
    required this.id,
    required this.accountName,
    required this.login,
    required this.password,
    required this.description,
    required this.createAt,
    required this.isCreator,
    required this.userId,
    this.validationAccount,
  });
}
