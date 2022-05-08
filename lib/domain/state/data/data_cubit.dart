import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/model/data.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/repository/crud_account_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_notes_repository.dart';
import 'package:passmanager_diplom/domain/repository/data_repository.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({
    required this.dataRepository,
    required this.crudNotesRepository,
    required this.crudAccountRepository,
  }) : super(DataInitial(const <Notes>[], const <Account>[], const <Data>[]));

  final DataRepository dataRepository;
  final CRUDNotesRepository crudNotesRepository;
  final CRUDAccountRepository crudAccountRepository;

  final List<Data> _dataList = <Data>[];
  final List<Notes> _notesList = <Notes>[];
  final List<Account> _accountList = <Account>[];
  bool isInit = false;

  Data DataMapper(TypeTable typeTable, dynamic data) {
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
        return Data(
            id: 0,
            name: '',
            createAt: DateTime.now(),
            isCreator: true,
            typeTable: TypeTable.files);

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
    }
  }

  void initData(int userId) async {
    if (!isInit) {
      emit(DataLoad(state.notesList, state.accountList, state.dataList));
      _dataList.addAll(await dataRepository.index(userId: userId));
      _notesList.addAll(await crudNotesRepository.index(userId: userId));
      _accountList.addAll(await crudAccountRepository.index(userId: userId));
      emit(DataResponse(_notesList, _accountList, _dataList));
      isInit = true;
    }
  }

  void addNotes(Notes notes) {
    _notesList.insert(0, notes);
    _dataList.insert(0, DataMapper(TypeTable.notes, notes));
    emit(DataResponse(_notesList, state.accountList, _dataList));
  }

  void updateNotes(Notes notes) {
    int index = _notesList.indexWhere((element) => element.id == notes.id);
    int dataIndex = _dataList.indexWhere((element) =>
        (element.id == notes.id) && (element.typeTable == TypeTable.notes));
    _notesList.removeWhere((element) => element.id == notes.id);
    _dataList.removeWhere((element) =>
        (element.id == notes.id) && (element.typeTable == TypeTable.notes));
    _notesList.insert(index, notes);
    _dataList.insert(dataIndex, DataMapper(TypeTable.notes, notes));
    emit(DataResponse(_notesList, state.accountList, _dataList));
  }

  void addAccount(Account account) {
    _accountList.insert(0, account);
    _dataList.insert(0, DataMapper(TypeTable.account, account));
    emit(DataResponse(state.notesList, _accountList, _dataList));
  }

  void updateAccount(Account account) {
    int index = _accountList.indexWhere((element) => element.id == account.id);
    int dataIndex = _dataList.indexWhere((element) =>
        (element.id == account.id) && (element.typeTable == TypeTable.account));
    _accountList.removeWhere((element) => element.id == account.id);
    _dataList.removeWhere((element) =>
        (element.id == account.id) && (element.typeTable == TypeTable.account));
    _accountList.insert(index, account);
    _dataList.insert(dataIndex, DataMapper(TypeTable.account, account));
    emit(DataResponse(state.notesList, _accountList, _dataList));
  }

  void onExit() {
    isInit = false;
    _notesList.clear();
    _dataList.clear();
    _accountList.clear();
    RepositoryModule.crudRepository().delete();
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
    }
    emit(DataResponse(_notesList, _accountList, _dataList));
  }

  Future onRefresh({
    required TypeTable typetable,
    required int userId,
  }) async {
    emit(DataLoad(state.notesList, state.accountList, state.dataList));
    switch (typetable) {
      case TypeTable.notes:
        {
          _notesList.clear();
          _notesList.addAll(await crudNotesRepository.index(userId: userId));
          break;
        }
      case TypeTable.files:
        {
          break;
        }
      case TypeTable.account:
        {
          _accountList.clear();
          _accountList
              .addAll(await crudAccountRepository.index(userId: userId));
          break;
        }
      default:
        {
          _dataList.clear();
          _dataList.addAll(await dataRepository.index(userId: userId));
        }
    }
    emit(DataResponse(_notesList, _accountList, _dataList));
  }
}
