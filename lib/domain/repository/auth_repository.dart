import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart';
import 'package:passmanager_diplom/domain/model/confirmation_new_login.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_new_login.dart';
import 'package:passmanager_diplom/domain/model/validation_new_password.dart';
import 'package:passmanager_diplom/domain/model/validation_new_user_name.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';

abstract class AuthRepository {
  Future<User> singUp({
    required String userName,
    required String login,
    required String password,
  });

  Future<User> singIn({
    required String login,
    required String password,
  });

  Future<Confirmation> confirmation({
    required String userName,
    required String login,
    required String password,
  });

  Future<ConfirmationNewLogin> confirmationNewLogin({
    required int id,
    required String login,
  });

  Future<ValidationNewLogin> newLogin({
    required int id,
    required String login,
  });

  Future<ValidationNewPassword> newPassword({
    required int id,
    required String oldPassword,
    required String newPassword,
  });

  Future<ValidationNewUserName> newUserName({
    required int id,
    required String userName,
  });
}
