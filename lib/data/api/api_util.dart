import 'package:passmanager_diplom/data/api/request/request_account_create.dart';
import 'package:passmanager_diplom/data/api/request/request_account_update.dart';
import 'package:passmanager_diplom/data/api/request/request_confirmation.dart';
import 'package:passmanager_diplom/data/api/request/request_notes_create.dart';
import 'package:passmanager_diplom/data/api/request/request_notes_update.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_in.dart';
import 'package:passmanager_diplom/data/api/request/request_sing_up.dart';
import 'package:passmanager_diplom/data/api/service/sunrice_service.dart';
import 'package:passmanager_diplom/data/mapper/account_mapper.dart';
import 'package:passmanager_diplom/data/mapper/confirmation_mapper.dart';
import 'package:passmanager_diplom/data/mapper/data_mapper.dart';
import 'package:passmanager_diplom/data/mapper/notes_mapper.dart';
import 'package:passmanager_diplom/data/mapper/user_mapper.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart';
import 'package:passmanager_diplom/domain/model/data.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
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

  Future<Confirmation> confirmation({
    required String userName,
    required String login,
    required String password,
  }) async {
    final request = RequestConfirmation(
        userName: userName, login: login, password: password);
    var result = await _sunriseService.confirmation(request);
    return ConfirmationMapper.fropApi(confirmation: result, user: request);
  }

  Future<Notes> notesCreate({
    required String notesName,
    required String content,
    required String description,
    required int userId,
  }) async {
    final request = RequestNotesCreate(
      notesName: notesName,
      content: content,
      description: description,
      userId: userId,
    );
    final result = await _sunriseService.notesCreate(request);
    return NotesMapper.fromApi(notes: result);
  }

  Future<List<Notes>> notesIndex({required int userId}) async {
    final result = await _sunriseService.notesIndex(userId: userId);
    return result.map((e) => NotesMapper.fromApi(notes: e)).toList();
  }

  Future<Notes> notesUpdate({
    required int notesId,
    required String notesName,
    required String content,
    required String description,
  }) async {
    final request = RequestNotesUpdate(
      notesName: notesName,
      content: content,
      description: description,
    );
    final result =
        await _sunriseService.notesUpdate(request: request, notesId: notesId);
    return NotesMapper.fromApi(notes: result);
  }

  Future<Account> accountCreate({
    required String accountName,
    required String login,
    required String password,
    required String description,
    required int userId,
  }) async {
    final request = RequestAccountCreate(
        accountName: accountName,
        login: login,
        password: password,
        description: description,
        userId: userId);
    final result = await _sunriseService.accountCreate(request: request);
    return AccountMapper.fromApi(account: result);
  }

  Future<List<Account>> accountIndex({required int userId}) async {
    final result = await _sunriseService.accountIndex(userId: userId);
    return result.map((e) => AccountMapper.fromApi(account: e)).toList();
  }

  Future<Account> accountUpdate({
    required int id,
    required String accountName,
    required String login,
    required String password,
    required String description,
  }) async {
    final request = RequestAccountUpdate(
      id: id,
      accountName: accountName,
      login: login,
      password: password,
      description: description,
    );
    final result = await _sunriseService.accountUpdate(request: request);
    return AccountMapper.fromApi(account: result);
  }

  Future<List<Data>> dataIndex({required int userId}) async {
    final result = await _sunriseService.dataIndex(userId: userId);
    return result.map((e) => DataMapper.fromApi(data: e)).toList();
  }
}
