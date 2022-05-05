import 'package:passmanager_diplom/data/api/model/api_notes.dart';

class ApiNotesList {
  final List<ApiNotes> notesList;

  ApiNotesList.fromApi(dynamic jsonList)
      : notesList = (jsonList as List).map((e) => ApiNotes.fromApi(e)).toList();
}
