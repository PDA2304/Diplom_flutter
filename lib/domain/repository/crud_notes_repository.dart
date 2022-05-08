import 'package:passmanager_diplom/domain/model/notes.dart';

abstract class CRUDNotesRepository {
  Future<Notes> create({
    required String notesName,
    required String content,
    required String description,
    required int userId,
  });
  Future<Notes> update({
    required int notesId,
    required String notesName,
    required String content,
    required String description,
  });
  Future<List<Notes>> index({required int userId});
  Future<Notes> logicDelete({required int id});
}
