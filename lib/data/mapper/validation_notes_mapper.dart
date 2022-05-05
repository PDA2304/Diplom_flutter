import 'package:passmanager_diplom/data/api/model/api_validation_notes.dart';
import 'package:passmanager_diplom/domain/model/validation_notes.dart';

class ValidationNotesMapper {
  static ValidationNotes fropApi(ApiValidationNotes? valid) {
    return valid == null
        ? ValidationNotes(
            notesName: null,
            content: null,
            description: null,
          )
        : ValidationNotes(
            notesName: valid.notesName.isEmpty ? null : valid.notesName.first,
            content: valid.content.isEmpty ? null : valid.content.first,
            description:
                valid.description.isEmpty ? null : valid.description.first);
  }
}
