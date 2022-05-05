import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/repository/crud_notes_repository.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(this.crudNotesRepository) : super(DataInitial(const <Notes>[]));

  final CRUDNotesRepository crudNotesRepository;

  final List<Notes> _notesList = <Notes>[];
  bool isInit = false;

  void initData(int userId) async {
    if (!isInit) {
      emit(DataLoad(state.notesList));
      isInit = true;
      _notesList.addAll(await crudNotesRepository.index(userId: userId));
      emit(DataResponse(_notesList));
    }
  }

  void addNotes(Notes notes) {
    _notesList.insert(0, notes);
    emit(DataResponse(_notesList));
  }

  void updateNotes(Notes notes) {
    int index = _notesList.indexWhere((element) => element.id == notes.id);
    _notesList.removeWhere((element) => element.id == notes.id);
    _notesList.insert(index, notes);
    emit(DataResponse(_notesList));
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
    emit(DataLoad(state.notesList));
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
          break;
        }
    }
    emit(DataResponse(_notesList));
  }
}
