import 'package:meta/meta.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

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

  Future<String> confirmation(String login);
}
