import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';
import 'package:passmanager_diplom/domain/model/validation_new_login.dart';
import 'package:passmanager_diplom/domain/model/validation_new_password.dart';
import 'package:passmanager_diplom/domain/model/validation_new_user_name.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_reposittiry.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:path_provider/path_provider.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._dataCubit, this._authRepository, this._crudRepository)
      : super(SettingsInitial());

  final DataCubit _dataCubit;
  final AuthRepository _authRepository;
  final CRUDRepository _crudRepository;
  TextEditingController userNameController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController pinPut = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  bool isLoadUserName = false;
  bool isChangeUserName = false;
  bool isLoadLogin = false;
  bool isChangeLogin = false;
  bool isPinCode = true;

  String saveUserName = '';
  String saveLogin = '';
  String code = '';

  String size = '';

  ValidationNewUserName? validationNewUserName;
  ValidationNewLogin? validationNewLogin;
  ValidationNewPassword? validationNewPassword;

  void init(String userName, String login) {
    userNameController.text = saveUserName = userName;
    loginController.text = saveLogin = login;
    directorySize();
  }

  void newUserName(int id, BuildContext context) async {
    isLoadUserName = isChangeUserName = true;
    emit(SettingsInitial());
    var value = await _authRepository.newUserName(
        id: id, userName: userNameController.text);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (value.userName == null) {
          _showSnackBar(context, '?????? ???????????????????????? ???????? ????????????????');
          isLoadUserName = isChangeUserName = false;
          saveUserName = userNameController.text;
          _crudRepository.update('userName', userNameController.text.trim());
          _dataCubit.drawer(
            User(
              id: id,
              userName: userNameController.text,
              email: loginController.text,
              validationAuth: ValidationAuth.Empty(),
            ),
          );
          emit(SettingsInitial());
        } else {
          isLoadUserName = false;
          validationNewUserName = value;
          emit(SettingsNewUserName());
        }
      },
    );
  }

  void confirmationNewLogin(int id, BuildContext context) async {
    isLoadLogin = isChangeLogin = true;
    emit(SettingsInitial());
    _authRepository
        .confirmationNewLogin(id: id, login: loginController.text)
        .then((value) {
      if (value.number != 0) {
        code = value.number.toString();
        isPinCode = false;
        isLoadLogin = false;

        emit(SettingsInitial());
      } else {
        isLoadLogin = false;
        validationNewLogin = value.validationNewLogin;
        emit(SettingsInitial());
      }
    });
  }

  void newLogin(int id, BuildContext context) async {
    _authRepository.newLogin(id: id, login: loginController.text).then((value) {
      _showSnackBar(context, '?????????? ???????????????????????? ?????? ??????????????');
      isLoadLogin = isChangeLogin = false;
      saveLogin = loginController.text;
      _crudRepository.update('email', loginController.text.trim());
      _dataCubit.drawer(
        User(
          id: id,
          userName: userNameController.text,
          email: loginController.text,
          validationAuth: ValidationAuth.Empty(),
        ),
      );
      emit(SettingsInitial());
    });
  }

  void newPassoword(BuildContext context, int id) {
    _authRepository
        .newPassword(
            id: id,
            oldPassword: oldPassword.text,
            newPassword: newPassword.text)
        .then((value) {
      if (value.newPassword == null && value.oldPassword == null) {
        Navigator.pop(context);
        _showSnackBar(context, '???????????? ?????? ??????????????');
        emit(SettingsInitial());
      }
      validationNewPassword = value;
      emit(SettingsInitial());
    });
  }

  void _showSnackBar(BuildContext context, String content) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.all(5),
          width: 150,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Text(
              content,
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void directorySize() async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    var dir = Directory("${documentDirectory.path}/PassManager");
    int totalSize = 0;
    try {
      if (dir.existsSync()) {
        dir
            .listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        });
      } else {
        size = "0";
      }
    } catch (e) {
      print(e.toString());
    }
    size = totalSize > 1000000000
        ? (totalSize / 1024 / 1024 / 1024).toStringAsFixed(2) + " ????"
        : (totalSize / 1024 / 1024).toStringAsFixed(2) + ' ????';
    emit(SettingsInitial());
  }

  void deleteFile() async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    var dir = Directory("${documentDirectory.path}/PassManager");
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
      size = '0';
      emit(SettingsInitial());
    }
  }
}
