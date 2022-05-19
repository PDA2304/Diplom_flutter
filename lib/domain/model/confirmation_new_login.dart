import 'package:passmanager_diplom/domain/model/validation_new_login.dart';

class ConfirmationNewLogin {
  final int number;
  final ValidationNewLogin? validationNewLogin;

  ConfirmationNewLogin({
    required this.number,
    required this.validationNewLogin,
  });

  ConfirmationNewLogin.Empty()
      : number = 0,
        validationNewLogin = null;
}
