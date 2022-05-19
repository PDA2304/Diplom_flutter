part of 'data_cubit.dart';

@immutable
abstract class DataState {
  final List<Data> dataList;
  final List<Notes> notesList;
  final List<Account> accountList;

  DataState(this.notesList, this.accountList, this.dataList);
}

class DataInitial extends DataState {
  DataInitial(
      List<Notes> notesList, List<Account> accountList, List<Data> dataList)
      : super(notesList, accountList, dataList);
}

class DataLoad extends DataState {
  DataLoad(
      List<Notes> notesList, List<Account> accountList, List<Data> dataList)
      : super(notesList, accountList, dataList);
}

class DataResponse extends DataState {
  final List<Data> dataList;
  final List<Notes> notesList;
  final List<Account> accountList;

  DataResponse(this.notesList, this.accountList, this.dataList)
      : super(notesList, accountList, dataList);
}

class DrawerUpdate extends DataState {
  User user =
      User(email: '', userName: '', id: 0, validationAuth: ValidationAuth());

  DrawerUpdate(this.user, List<Notes> notesList, List<Account> accountList,
      List<Data> dataList)
      : super(notesList, accountList, dataList);
}
