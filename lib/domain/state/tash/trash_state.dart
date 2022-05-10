part of 'trash_cubit.dart';

@immutable
abstract class TrashState {
  bool isPressed = false;
}

class TrashInitial extends TrashState {}

class TrashLoad extends TrashState {}

class TrashResponse extends TrashState {
  final List<TrashData> trashList;

  TrashResponse(this.trashList);
}
