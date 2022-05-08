import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/repository/crud_notes_repository.dart';

class CRUDDataNotesRepository extends CRUDNotesRepository {
  final ApiUtil _apiUtil;
  CRUDDataNotesRepository(this._apiUtil);

  @override
  Future<Notes> create({
    required String notesName,
    required String content,
    required String description,
    required int userId,
  }) {
    return _apiUtil.notesCreate(
        notesName: notesName,
        content: content,
        description: description,
        userId: userId);
  }

  @override
  Future<List<Notes>> index({required int userId}) {
    return _apiUtil.notesIndex(userId: userId);
  }

  @override
  Future<Notes> logicDelete({required int id}) {
    return _apiUtil.notesDelete(id: id);
  }

  @override
  Future<Notes> update({
    required int notesId,
    required String notesName,
    required String content,
    required String description,
  }) {
    return _apiUtil.notesUpdate(
      notesId: notesId,
      notesName: notesName,
      content: content,
      description: description,
    );
  }
}
