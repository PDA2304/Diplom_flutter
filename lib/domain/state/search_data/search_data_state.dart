part of 'search_data_cubit.dart';

abstract class SearchDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchDataInitial extends SearchDataState {}

// class SearchNotes extends SearchDataState {
//   final List<Notes> list;

//   SearchNotes(this.list) : super(list.length);
// }

// class SearchAccount extends SearchDataState {
//   final List<Account> list;

//   SearchAccount(this.list) : super(list.length);
// }

// class SearchFiles extends SearchDataState {
//   final List<File> list;

//   SearchFiles(this.list) : super(list.length);
// }

class SearchData extends SearchDataState {
  final List<Data> list;

  SearchData(this.list);
}
