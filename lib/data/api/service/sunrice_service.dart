import 'package:dio/dio.dart';
import 'package:passmanager_diplom/data/api/model/api_account.dart';
import 'package:passmanager_diplom/data/api/model/api_account_list.dart';
import 'package:passmanager_diplom/data/api/model/api_confirmation.dart';
import 'package:passmanager_diplom/data/api/model/api_notes.dart';
import 'package:passmanager_diplom/data/api/model/api_notes_list.dart';
import 'package:passmanager_diplom/data/api/model/api_user.dart';
import 'package:passmanager_diplom/data/api/request/request_account_create.dart';
import 'package:passmanager_diplom/data/api/request/request_account_update.dart';
import 'package:passmanager_diplom/data/api/request/request_confirmation.dart';
import 'package:passmanager_diplom/data/api/request/request_notes_create.dart';
import 'package:passmanager_diplom/data/api/request/request_notes_update.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_in.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_up.dart';

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
      if (e.response != null) return ApiUser.fromApi(e.response!.data);
      return ApiUser.fromApi({});
    }
  }

  Future<ApiConfirmation> confirmation(RequestConfirmation request) async {
    try {
      final response = await _dio.post('confirmation', data: request.toApi());
      return ApiConfirmation.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null) return ApiConfirmation.fromApi(e.response!.data);
      return ApiConfirmation.fromApi({'number': 0});
    }
  }

  Future<ApiNotes> notesCreate(RequestNotesCreate request) async {
    try {
      final response = await _dio.post('notes', data: request.toApi());
      return ApiNotes.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null) return ApiNotes.fromApi(e.response!.data);
      return ApiNotes.fromApi({});
    }
  }

  Future<List<ApiNotes>> notesIndex({required int userId}) async {
    try {
      final response = await _dio.get('notes/user/$userId');
      return ApiNotesList.fromApi(response.data).notesList;
    } on DioError catch (e) {
      return <ApiNotes>[];
    }
  }

  Future<ApiNotes> notesUpdate(
      {required RequestNotesUpdate request, required notesId}) async {
    try {
      final response = await _dio.put('notes/$notesId', data: request.toApi());
      return ApiNotes.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null) return ApiNotes.fromApi(e.response!.data);
      return ApiNotes.fromApi({});
    }
  }

  Future<ApiAccount> accountCreate(
      {required RequestAccountCreate request}) async {
    try {
      final response = await _dio.post('account', data: request.toApi());
      return ApiAccount.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null) return ApiAccount.fromApi(e.response!.data);
      return ApiAccount.fromApi({});
    }
  }

  Future<List<ApiAccount>> accountIndex({required int userId}) async {
    try {
      final response = await _dio.get('account/user/$userId');
      return ApiAccountList.fromApi(response.data).accountList;
    } on DioError catch (e) {
      return <ApiAccount>[];
    }
  }

  accountUpdate({required RequestAccountUpdate request}) async {
    try {
      final response = await _dio.put('account', data: request.toApi());
      return ApiAccount.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null) return ApiAccount.fromApi(e.response!.data);
      return ApiAccount.fromApi({});
    }
  }
}
