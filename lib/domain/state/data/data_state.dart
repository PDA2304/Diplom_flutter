part of 'data_cubit.dart';

@immutable
abstract class DataState {
  final List<Notes> notesList;
  final List<Account> accountList;

  DataState(this.notesList, this.accountList);
}

class DataInitial extends DataState {
  DataInitial(List<Notes> notesList, List<Account> accountList)
      : super(notesList, accountList);
}

class DataLoad extends DataState {
  DataLoad(List<Notes> notesList, List<Account> accountList)
      : super(notesList, accountList);
}

class DataResponse extends DataState {
  final List<Notes> notesList;
  final List<Account> accountList;

  DataResponse(this.notesList, this.accountList)
      : super(notesList, accountList);
}
