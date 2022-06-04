import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/model/data.dart';
import 'package:passmanager_diplom/domain/model/files.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/model/trash_data.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';
import 'package:passmanager_diplom/domain/repository/crud_account_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_files_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_notes_repository.dart';
import 'package:passmanager_diplom/domain/repository/data_repository.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';
import 'package:path_provider/path_provider.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({
    required this.dataRepository,
    required this.crudNotesRepository,
    required this.crudAccountRepository,
    required this.crudFilesRepository,
  }) : super(DataInitial(const <Notes>[], const <Account>[], const <Data>[],
            const <File>[]));

  final DataRepository dataRepository;
  final CRUDNotesRepository crudNotesRepository;
  final CRUDAccountRepository crudAccountRepository;
  final CRUDFilesRepository crudFilesRepository;

  final List<Data> _dataList = <Data>[];
  final List<Notes> _notesList = <Notes>[];
  final List<Account> _accountList = <Account>[];
  final List<File> _filesList = <File>[];

  bool isInit = false;

  void drawer(User user) {
    emit(DrawerUpdate(user, state.notesList, state.accountList, state.dataList,
        state.filesList));
  }

  Data dataMapper(TypeTable typeTable, dynamic data) {
    switch (typeTable) {
      case TypeTable.notes:
        {
          Notes notes = data as Notes;
          return Data(
            id: notes.id,
            name: notes.notesName,
            createAt: notes.createAt,
            isCreator: notes.isCreator,
            typeTable: TypeTable.notes,
          );
        }
      case TypeTable.files:
        File file = data as File;
        return Data(
          id: file.id,
          name: file.fileName,
          createAt: file.createdAt,
          isCreator: file.isCreator,
          typeTable: TypeTable.files,
        );

      case TypeTable.account:
        {
          Account account = data as Account;
          return Data(
              id: account.id,
              name: account.accountName,
              createAt: account.createAt,
              isCreator: account.isCreator,
              typeTable: TypeTable.account);
        }
      case TypeTable.data:
        {
          return Data(
            id: 0,
            name: '',
            isCreator: true,
            createAt: DateTime.now(),
            typeTable: TypeTable.data,
          );
        }
    }
  }

  void initData(int userId) async {
    if (!isInit) {
      emit(DataLoad(
          state.notesList, state.accountList, state.dataList, state.filesList));
      _dataList.addAll(await dataRepository.index(userId: userId));
      _notesList.addAll(await crudNotesRepository.index(userId: userId));
      _filesList.addAll(await crudFilesRepository.index(userId: userId));
      _accountList.addAll(await crudAccountRepository.index(userId: userId));
      emit(DataResponse(_notesList, _accountList, _dataList, _filesList));
      isInit = true;
    }
  }

  void addNotes(Notes notes) {
    _notesList.insert(0, notes);
    _dataList.insert(0, dataMapper(TypeTable.notes, notes));
    emit(DataResponse(_notesList, state.accountList, _dataList, _filesList));
  }

  void updateNotes(Notes notes) {
    int index = _notesList.indexWhere((element) => element.id == notes.id);
    int dataIndex = _dataList.indexWhere((element) =>
        (element.id == notes.id) && (element.typeTable == TypeTable.notes));
    _notesList.removeWhere((element) => element.id == notes.id);
    _dataList.removeWhere((element) =>
        (element.id == notes.id) && (element.typeTable == TypeTable.notes));
    _notesList.insert(index, notes);
    _dataList.insert(dataIndex, dataMapper(TypeTable.notes, notes));
    emit(DataResponse(_notesList, state.accountList, _dataList, _filesList));
  }

  void addAccount(Account account) {
    _accountList.insert(0, account);
    _dataList.insert(0, dataMapper(TypeTable.account, account));
    emit(DataResponse(state.notesList, _accountList, _dataList, _filesList));
  }

  void updateAccount(Account account) {
    int index = _accountList.indexWhere((element) => element.id == account.id);
    int dataIndex = _dataList.indexWhere((element) =>
        (element.id == account.id) && (element.typeTable == TypeTable.account));
    _accountList.removeWhere((element) => element.id == account.id);
    _dataList.removeWhere((element) =>
        (element.id == account.id) && (element.typeTable == TypeTable.account));
    _accountList.insert(index, account);
    _dataList.insert(dataIndex, dataMapper(TypeTable.account, account));
    emit(DataResponse(state.notesList, _accountList, _dataList, _filesList));
  }

  void addFiles(File files) {
    _filesList.insert(0, files);
    _dataList.insert(0, dataMapper(TypeTable.files, files));
    emit(DataResponse(state.notesList, _accountList, _dataList, _filesList));
  }

  void updateFiles(File files) {
    int index = _filesList.indexWhere((element) => element.id == files.id);
    int dataIndex = _dataList.indexWhere((element) =>
        (element.id == files.id) && (element.typeTable == TypeTable.files));
    _filesList.removeWhere((element) => element.id == files.id);
    _dataList.removeWhere((element) =>
        (element.id == files.id) && (element.typeTable == TypeTable.files));
    _filesList.insert(index, files);
    _dataList.insert(dataIndex, dataMapper(TypeTable.files, files));
    emit(DataResponse(state.notesList, _accountList, _dataList, _filesList));
  }

  void onExit() {
    isInit = false;
    _notesList.clear();
    _dataList.clear();
    _filesList.clear();
    _accountList.clear();
    RepositoryModule.crudRepository().delete();
    deleteFile();
  }

  void deleteFile() async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    var dir = Directory("${documentDirectory.path}/PassManager");
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }

  void onDelete(TypeTable typeTable, int id) {
    switch (typeTable) {
      case TypeTable.notes:
        {
          _notesList.removeWhere((element) => element.id == id);
          _dataList.removeWhere((element) =>
              (element.id == id) && (element.typeTable == TypeTable.notes));
          crudNotesRepository.logicDelete(id: id);
          break;
        }
      case TypeTable.files:
        {
          _filesList.removeWhere((element) => element.id == id);
          _dataList.removeWhere((element) =>
              (element.id == id) && (element.typeTable == TypeTable.files));
          crudFilesRepository.logicDelete(id: id);
          break;
        }
      case TypeTable.account:
        {
          _accountList.removeWhere((element) => element.id == id);
          _dataList.removeWhere((element) =>
              (element.id == id) && (element.typeTable == TypeTable.account));
          crudAccountRepository.logicDelete(id: id);
          break;
        }
      case TypeTable.data:
        break;
    }
    emit(DataResponse(_notesList, _accountList, _dataList, _filesList));
  }

  Future onRefresh({
    required TypeTable typetable,
    required int userId,
  }) async {
    emit(DataLoad(
        state.notesList, state.accountList, state.dataList, state.filesList));
    switch (typetable) {
      case TypeTable.notes:
        {
          _notesList.clear();
          _dataList.clear();
          _dataList.addAll(await dataRepository.index(userId: userId));
          _notesList.addAll(await crudNotesRepository.index(userId: userId));
          break;
        }
      case TypeTable.files:
        {
          _filesList.clear();
          _dataList.clear();
          _dataList.addAll(await dataRepository.index(userId: userId));
          _filesList.addAll(await crudFilesRepository.index(userId: userId));
          break;
        }
      case TypeTable.account:
        {
          _accountList.clear();
          _dataList.clear();
          _dataList.addAll(await dataRepository.index(userId: userId));
          _accountList
              .addAll(await crudAccountRepository.index(userId: userId));

          break;
        }
      case TypeTable.data:
        {
          _dataList.clear();
          _accountList.clear();
          _filesList.clear();
          _notesList.clear();

          _notesList.addAll(await crudNotesRepository.index(userId: userId));
          _filesList.addAll(await crudFilesRepository.index(userId: userId));
          _accountList
              .addAll(await crudAccountRepository.index(userId: userId));
          _dataList.addAll(await dataRepository.index(userId: userId));
        }
    }
    emit(DataResponse(_notesList, _accountList, _dataList, _filesList));
  }

  void restoration({required List<TrashData> data, required int userId}) async {
    _notesList.clear();
    _accountList.clear();
    _filesList.clear();
    _dataList.addAll(data
        .map(
          (e) => Data(
            id: e.id,
            name: e.name,
            createAt: e.createAt,
            isCreator: e.isCreator,
            typeTable: e.typeTable,
          ),
        )
        .toList());
    _dataList.sort((a, b) {
      return b.createAt.compareTo(a.createAt);
    });

    _notesList.addAll(await crudNotesRepository.index(userId: userId));
    _accountList.addAll(await crudAccountRepository.index(userId: userId));
    _filesList.addAll(await crudFilesRepository.index(userId: userId));
    emit(DataResponse(_notesList, _accountList, _dataList, _filesList));
  }
}
