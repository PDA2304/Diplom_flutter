import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart';
import 'package:passmanager_diplom/domain/model/confirmation_new_login.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_new_login.dart';
import 'package:passmanager_diplom/domain/model/validation_new_password.dart';
import 'package:passmanager_diplom/domain/model/validation_new_user_name.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';

class AuthDataRepository extends AuthRepository {
  final ApiUtil _apiUtil;
  AuthDataRepository(this._apiUtil);

  @override
  Future<User> singIn({required String login, required String password}) {
    return _apiUtil.singIn(
      login: login,
      password: password,
    );
  }

  @override
  Future<User> singUp({
    required String userName,
    required String login,
    required String password,
  }) {
    return _apiUtil.singUp(
      userName: userName,
      login: login,
      password: password,
    );
  }

  @override
  Future<Confirmation> confirmation({
    required String userName,
    required String login,
    required String password,
  }) {
    return _apiUtil.confirmation(
      userName: userName,
      login: login,
      password: password,
    );
  }

  @override
  Future<ValidationNewPassword> newPassword({
    required int id,
    required String oldPassword,
    required String newPassword,
  }) {
    return _apiUtil.newPassword(
      id: id,
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
  }

  @override
  Future<ValidationNewUserName> newUserName(
      {required int id, required String userName}) {
    return _apiUtil.newUserName(id: id, userName: userName);
  }

  @override
  Future<ValidationNewLogin> newLogin(
      {required int id, required String login}) {
    return _apiUtil.newLogin(id: id, login: login);
  }

  @override
  Future<ConfirmationNewLogin> confirmationNewLogin({
    required int id,
    required String login,
  }) {
    return _apiUtil.confirmationNewLogin(id: id, login: login);
  }
}
