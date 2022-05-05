import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._dataCubit) : super(NotesInitial());

  final DataCubit _dataCubit;

  void notesCreate({
    required String notesName,
    required String content,
    required String description,
    required int userId,
  }) async {
    emit(NotesLoad());
    var notes = await _dataCubit.crudNotesRepository.create(
      notesName: notesName,
      content: content,
      description: description,
      userId: userId,
    );

    if (notes.validationNotes == null) {
      if (notes.id != 0) _dataCubit.addNotes(notes);
      emit(NotesAddResponse(notes: notes, isSeccus: true));
    } else {
      emit(NotesAddResponse(notes: notes, isSeccus: false));
    }
  }

  void notesUpdate({
    required int notesId,
    required String notesName,
    required String content,
    required String description,
  }) async {
    var notes = await _dataCubit.crudNotesRepository.update(
      notesId: notesId,
      notesName: notesName,
      content: content,
      description: description,
    );

    if (notes.validationNotes == null) {
      _dataCubit.updateNotes(notes);
      emit(NotesUpdate(notes, true));
    } else {
      emit(NotesUpdate(notes, false));
    }
  }
}
