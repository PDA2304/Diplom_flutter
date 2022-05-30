part of 'files_cubit.dart';

@immutable
abstract class FilesState {}

class FilesInitial extends FilesState {}

class FilesErorr extends FilesState {
  final File files;

  FilesErorr(this.files);
}

class FilesResponse extends FilesState {
}
