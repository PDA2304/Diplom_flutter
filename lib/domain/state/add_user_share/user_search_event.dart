part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class RequestEvent extends UserSearchEvent {
  final String search;
  final TypeTable typeTable;
  final int dataId;

  RequestEvent(this.search, this.typeTable, this.dataId);
}

class CheckUserEvent extends UserSearchEvent {
  final int id;
  final bool check;

  CheckUserEvent(this.id, this.check);
}

class RemoveCheckUserEvent extends UserSearchEvent {
  final User user;

  RemoveCheckUserEvent(this.user);
}

class AddShareUserEvent extends UserSearchEvent {
  final TypeTable typeTable;
  final int userSenderId;
  final int dataId;

  AddShareUserEvent({
    required this.typeTable,
    required this.dataId,
    required this.userSenderId,
  });
}
