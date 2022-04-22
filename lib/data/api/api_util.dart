import 'package:dio/dio.dart';
import 'package:passmanager_diplom/data/api/request/request_confirmation.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_in.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_up.dart';
import 'package:passmanager_diplom/data/api/service/sunrice_service.dart';
import 'package:passmanager_diplom/data/mapper/user_mapper.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

class ApiUtil {
  final SunriseService _sunriseService;
  ApiUtil(this._sunriseService);

  Future<User> singUp({
    required String userName,
    required String login,
    required String password,
  }) async {
    final request = RequestSingUp(
      userName: userName,
      login: login,
      password: password,
    );
    var result = await _sunriseService.singUp(request);
    return UserMapper.fropApi(result);
  }

  Future<User> singIn({
    required String login,
    required String password,
  }) async {
    final request = RequestSingIn(login: login, password: password);
    var result = await _sunriseService.singIn(request);
    return UserMapper.fropApi(result);
  }

  Future<String> confirmation(String login) async {
    final request = RequestConfirmation(login);
    var result = await _sunriseService.confirmation(request);
    return result;
  }
}
