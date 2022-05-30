part of 'data_cubit.dart';

@immutable
abstract class DataState {
  final List<Data> dataList;
  final List<Notes> notesList;
  final List<Account> accountList;
  final List<File> filesList;

  DataState(this.notesList, this.accountList, this.dataList, this.filesList);
}

class DataInitial extends DataState {
  DataInitial(List<Notes> notesList, List<Account> accountList,
      List<Data> dataList, List<File> filesList)
      : super(notesList, accountList, dataList, filesList);
}

class DataLoad extends DataState {
  DataLoad(List<Notes> notesList, List<Account> accountList,
      List<Data> dataList, List<File> filesList)
      : super(notesList, accountList, dataList, filesList);
}

class DataResponse extends DataState {
  final List<Data> dataList;
  final List<Notes> notesList;
  final List<Account> accountList;
  final List<File> filesList;

  DataResponse(this.notesList, this.accountList, this.dataList, this.filesList)
      : super(notesList, accountList, dataList, filesList);
}

class DrawerUpdate extends DataState {
  User user =
      User(email: '', userName: '', id: 0, validationAuth: ValidationAuth());

  DrawerUpdate(this.user, List<Notes> notesList, List<Account> accountList,
      List<Data> dataList, List<File> filesList)
      : super(notesList, accountList, dataList, filesList);
}
