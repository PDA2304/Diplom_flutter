import 'package:dio/dio.dart';
import 'package:passmanager_diplom/data/api/model/api_account.dart';
import 'package:passmanager_diplom/data/api/model/api_account_list.dart';
import 'package:passmanager_diplom/data/api/model/api_confirmation.dart';
import 'package:passmanager_diplom/data/api/model/api_confirmation_new_login.dart';
import 'package:passmanager_diplom/data/api/model/api_data.dart';
import 'package:passmanager_diplom/data/api/model/api_data_information.dart';
import 'package:passmanager_diplom/data/api/model/api_file.dart';
import 'package:passmanager_diplom/data/api/model/api_file_list.dart';
import 'package:passmanager_diplom/data/api/model/api_history_action.dart';
import 'package:passmanager_diplom/data/api/model/api_history_action_list.dart';
import 'package:passmanager_diplom/data/api/model/api_notes.dart';
import 'package:passmanager_diplom/data/api/model/api_notes_list.dart';
import 'package:passmanager_diplom/data/api/model/api_user.dart';
import 'package:passmanager_diplom/data/api/model/api_user_share.dart';
import 'package:passmanager_diplom/data/api/model/api_user_share_list.dart';
import 'package:passmanager_diplom/data/api/model/api_validatio_new_user_name.dart';
import 'package:passmanager_diplom/data/api/model/api_validation_new_login.dart';
import 'package:passmanager_diplom/data/api/model/api_validation_new_password.dart';
import 'package:passmanager_diplom/data/api/request/request_account_create.dart';
import 'package:passmanager_diplom/data/api/request/request_account_update.dart';
import 'package:passmanager_diplom/data/api/request/request_confirmation.dart';
import 'package:passmanager_diplom/data/api/request/request_file_create.dart';
import 'package:passmanager_diplom/data/api/request/request_file_update.dart';
import 'package:passmanager_diplom/data/api/request/request_history_action.dart';
import 'package:passmanager_diplom/data/api/request/request_new_login.dart';
import 'package:passmanager_diplom/data/api/request/request_new_password.dart';
import 'package:passmanager_diplom/data/api/request/request_new_user_name.dart';
import 'package:passmanager_diplom/data/api/request/request_trash_list.dart';
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

  Future<ApiNotes> notesDelete({required int id}) async {
    try {
      final response = await _dio.delete('/notes/logicDelete/$id');
      return ApiNotes.fromApi(response.data);
    } on DioError catch (e) {
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

  Future<ApiAccount> accountUpdate(
      {required RequestAccountUpdate request}) async {
    try {
      final response = await _dio.put('account', data: request.toApi());
      return ApiAccount.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null) return ApiAccount.fromApi(e.response!.data);
      return ApiAccount.fromApi({});
    }
  }

  Future<ApiAccount> accountDelete({required int id}) async {
    try {
      final response = await _dio.delete('account/logicDelete/$id');
      return ApiAccount.fromApi(response.data);
    } on DioError catch (e) {
      return ApiAccount.fromApi({});
    }
  }

  Future<List<ApiData>> dataIndex({required int userId}) async {
    try {
      final response = await _dio.get('data/$userId');
      return ApiData.fromApiList(response.data);
    } on DioError catch (e) {
      return <ApiData>[];
    }
  }

  Future<List<ApiData>> trashIndex({required int userId}) async {
    try {
      final response = await _dio.get('trash/$userId');
      return ApiData.fromApiList(response.data);
    } on DioError catch (e) {
      return <ApiData>[];
    }
  }

  Future<bool> deleteData({required RequestTrashList request}) async {
    try {
      await _dio.delete('trash', data: request.toApi());
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> deleteAllData({required int userId}) async {
    try {
      await _dio.delete('trash/allUser/$userId');
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> restorationAllData({required int userId}) async {
    try {
      await _dio.post('trash/allUser/$userId');
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> restorationData({required RequestTrashList request}) async {
    try {
      await _dio.post('trash', data: request.toApi());
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<List<ApiHistoryAction>> indexHistoryAction(
      {required RequestInfromation request}) async {
    try {
      final response = await _dio.get('information/history_action',
          queryParameters: request.toApiHistoryAction());
      return ApiHistoryActionList.fromApi(response.data).list;
    } on DioError catch (e) {
      print(e.message);
      return <ApiHistoryAction>[];
    }
  }

  Future<List<ApiUserShare>> indexUserShare(
      {required RequestInfromation request}) async {
    try {
      final response = await _dio.get('information/user_share',
          queryParameters: request.toApiUserShare());
      return ApiUserShareList.fromApi(response.data).list;
    } on DioError catch (e) {
      print(e.message);
      return <ApiUserShare>[];
    }
  }

  Future<ApiDataInformation> indexDataInformation(
      {required RequestInfromation request}) async {
    try {
      final response = await _dio.get('information/data_information',
          queryParameters: request.toApiUserShare());
      return ApiDataInformation.fromApi(response.data);
    } on DioError catch (e) {
      print(e.message);
      return ApiDataInformation.fromApi({});
    }
  }

  Future<ApiValidationNewPassword> newPassword(
      {required RequestNewPassword request}) async {
    try {
      final response = await _dio.post('newPassword', data: request.toApi());
      return ApiValidationNewPassword.fromApi({});
    } on DioError catch (e) {
      if (e.response != null) {
        return ApiValidationNewPassword.fromApi(e.response!.data['error']);
      }
      return ApiValidationNewPassword.fromApi({});
    }
  }

  Future<ApiValidationNewLogin> newLogin(
      {required RequestNewLogin request}) async {
    try {
      final response = await _dio.post('newLogin', data: request.toApi());
      return ApiValidationNewLogin.fromApi({});
    } on DioError catch (e) {
      if (e.response != null) {
        return ApiValidationNewLogin.fromApi(e.response!.data['error']);
      }
      return ApiValidationNewLogin.fromApi({});
    }
  }

  Future<ApiValidationNewUserName> newUserName(
      {required RequestNewUserName request}) async {
    try {
      final reponse = await _dio.post('newUserName', data: request.toApi());
      return ApiValidationNewUserName.fromApi({});
    } on DioError catch (e) {
      if (e.response != null) {
        return ApiValidationNewUserName.fromApi(e.response!.data['error']);
      }
      return ApiValidationNewUserName.fromApi({});
    }
  }

  Future<ApiConfirmationNewLogin> confirmatioNewLogin(
      {required RequestNewLogin request}) async {
    try {
      final reponse =
          await _dio.post('confirmationNewLogin', data: request.toApi());
      return ApiConfirmationNewLogin.fromApi(reponse.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 422) {
        return ApiConfirmationNewLogin.fromApi(e.response!.data);
      }
      return ApiConfirmationNewLogin.fromApi({'number': 0});
    }
  }

  Future<ApiFile> createFile({required RequestFileCreate request}) async {
    try {
      var test = FormData.fromMap({
        'user_id': request.userId,
        'file_name': request.fileName,
        'description': request.description,
        'login': request.login,
        'size': request.size,
        'file': await MultipartFile.fromFile(request.file.path),
      });
      final response = await _dio.post('files', data: test);
      return ApiFile.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 422)
        return ApiFile.fromApi(e.response!.data);
      return ApiFile.fromApi({});
    }
  }

  Future<ApiFile> updateFile({required RequsetFileUpdate request}) async {
    try {
      var test = FormData.fromMap({
        '_method': 'PUT',
        'id': request.id,
        'file_name': request.fileName,
        'description': request.description,
        'size': request.size,
        'file': await MultipartFile.fromFile(request.file.path),
      });
      final response = await _dio.post('files', data: test);
      return ApiFile.fromApi(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 422)
        return ApiFile.fromApi(e.response!.data);
      return ApiFile.fromApi({});
    }
  }

  Future<List<ApiFile>> indexFile(int userId) async {
    try {
      final response = await _dio.get('files/user/$userId');
      return ApiFileList.fromApi(response.data).list;
    } on DioError catch (e) {
      return <ApiFile>[];
    }
  }

  Future<bool> filesDelete(int id) async {
    try {
      await _dio.delete('files/logicDelete/$id');
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }
}
