import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/repository/crud_account_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_notes_repository.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({
    required this.crudNotesRepository,
    required this.crudAccountRepository,
  }) : super(DataInitial(const <Notes>[], const <Account>[]));

  final CRUDNotesRepository crudNotesRepository;
  final CRUDAccountRepository crudAccountRepository;

  final List<Notes> _notesList = <Notes>[];
  final List<Account> _accountList = <Account>[];
  bool isInit = false;

  void initData(int userId) async {
    if (!isInit) {
      emit(DataLoad(state.notesList, state.accountList));
      _notesList.addAll(await crudNotesRepository.index(userId: userId));
      _accountList.addAll(await crudAccountRepository.index(userId: userId));
      emit(DataResponse(_notesList, _accountList));
      isInit = true;
    }
  }

  void addNotes(Notes notes) {
    _notesList.insert(0, notes);
    emit(DataResponse(_notesList, state.accountList));
  }

  void updateNotes(Notes notes) {
    int index = _notesList.indexWhere((element) => element.id == notes.id);
    _notesList.removeWhere((element) => element.id == notes.id);
    _notesList.insert(index, notes);
    emit(DataResponse(_notesList, state.accountList));
  }

  void addAccount(Account account) {
    _accountList.insert(0, account);
    emit(DataResponse(state.notesList, _accountList));
  }

  void updateAccount(Account account) {
    int index = _accountList.indexWhere((element) => element.id == account.id);
    _accountList.removeWhere((element) => element.id == account.id);
    _accountList.insert(index, account);
    emit(DataResponse(state.notesList, _accountList));
  }

  void onExit() {
    isInit = false;
    _notesList.clear();
    RepositoryModule.crudRepository().delete();
  }

  Future onRefresh({
    required TypeTable typetable,
    required int userId,
  }) async {
    emit(DataLoad(state.notesList, state.accountList));
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
    }
    emit(DataResponse(_notesList, _accountList));
  }
}
