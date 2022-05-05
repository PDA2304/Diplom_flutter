part of 'data_cubit.dart';

@immutable
abstract class DataState {
  final List<Notes> notesList;

  DataState(this.notesList);
}

class DataInitial extends DataState {
  DataInitial(List<Notes> notesList) : super(notesList);
}

class DataLoad extends DataState {
  DataLoad(List<Notes> notesList) : super(notesList);
}

class DataResponse extends DataState {
  final List<Notes> notesList;
  DataResponse(this.notesList) : super(notesList);
}
