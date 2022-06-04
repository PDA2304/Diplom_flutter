part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchState extends Equatable {
  final List<ShareUser> list;
  final List<User> listCheck;

  UserSearchState(this.list, this.listCheck);
}

class UserSearchInitial extends UserSearchState {
  UserSearchInitial(List<ShareUser> list, List<User> listCheck)
      : super(list, listCheck);

  @override
  List<Object?> get props => [];
}

class UserSearchLoad extends UserSearchState {
  UserSearchLoad(List<ShareUser> list, List<User> listCheck)
      : super(list, listCheck);

  @override
  List<Object?> get props => [];
}

class UserResponse extends UserSearchState {
  final List<ShareUser> list;

  UserResponse(this.list, List<User> listCheck) : super(list, listCheck);

  @override
  List<Object?> get props => [list, listCheck];
}

class ShareError extends UserSearchState {
  final String error;

  ShareError(List<ShareUser> list, List<User> listCheck, this.error)
      : super(list, listCheck);

  @override
  List<Object?> get props => [];
}

class ShareSucces extends UserSearchState {
  ShareSucces(List<ShareUser> list, List<User> listCheck)
      : super(list, listCheck);

  @override
  List<Object?> get props => [];
}
