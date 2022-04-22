import 'package:dio/dio.dart';
import 'package:passmanager_diplom/data/api/model/api_confirmation.dart';
import 'package:passmanager_diplom/data/api/model/api_user.dart';
import 'package:passmanager_diplom/data/api/model/api_validation_auth.dart';
import 'package:passmanager_diplom/data/api/request/request_confirmation.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_in.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_up.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

class SunriseService {
  static const _BASE_URL = 'http://192.168.157.128:8888/api/';

  final Dio _dio = Dio(BaseOptions(
      baseUrl: _BASE_URL, connectTimeout: 10000, receiveTimeout: 10000));

  Future<ApiUser> singUp(RequestSingUp request) async {
    try {
      final response = await _dio.post('sing_up', data: request.toApi());
      return ApiUser.fromApi(response.data);
    } on DioError catch (e) {
      return ApiUser.fromApi(e.response!.data);
    }
  }

  Future<ApiUser> singIn(RequestSingIn request) async {
    try {
      final reponse = await _dio.post('sing_in', data: request.toApi());
      return ApiUser.fromApi(reponse.data);
    } on DioError catch (e) {
      return ApiUser.fromApi(e.response!.data);
    }
  }

  Future<String> confirmation(RequestConfirmation request) async {
    final response = await _dio.post('confirmation', data: request);
    return ApiConfirmation.fromApi(response.data).number;
  }
}
