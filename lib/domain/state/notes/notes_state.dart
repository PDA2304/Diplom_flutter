part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoad extends NotesState {}

class NotesAddResponse extends NotesState {
  final Notes notes;
  final bool isSeccus;

  NotesAddResponse({
    required this.notes,
    required this.isSeccus,
  });
}

class NotesCansel extends NotesState {}

class NotesUpdate extends NotesState {
  final Notes notes;
  final bool isSeccus;

  NotesUpdate(this.notes,this.isSeccus);
}
