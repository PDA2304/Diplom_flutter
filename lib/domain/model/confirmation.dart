import 'package:passmanager_diplom/domain/model/validation_auth.dart';

class Confirmation {
  final int number;
  final String userName;
  final String login;
  final String password;
  final ValidationAuth? validationAuth;

  Confirmation({
    required this.number,
    required this.validationAuth,
    required this.userName,
    required this.login,
    required this.password,
  });
}
