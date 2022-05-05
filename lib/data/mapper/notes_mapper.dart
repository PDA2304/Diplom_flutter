import 'package:passmanager_diplom/data/api/model/api_notes.dart';
import 'package:passmanager_diplom/data/mapper/validation_notes_mapper.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';

class NotesMapper {
  static Notes fromApi({required ApiNotes notes}) {
    return Notes(
      id: notes.id!,
      notesName: notes.notesName!,
      content: notes.content!,
      description: notes.description!,
      createAt: DateTime.parse(notes.createAt!).toLocal(),
      isCreator: notes.isCreator!,
      userId: notes.userId!,
      validationNotes: notes.apiValidationNotes == null
          ? null
          : ValidationNotesMapper.fropApi(notes.apiValidationNotes),
    );
  }
}
