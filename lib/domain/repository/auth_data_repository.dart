import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
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
}
