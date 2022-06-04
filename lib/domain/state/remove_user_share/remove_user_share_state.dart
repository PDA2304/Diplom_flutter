part of 'remove_user_share_cubit.dart';

abstract class RemoveUserShareState extends Equatable {
  const RemoveUserShareState(this.list);

  final List<UserShare> list;

  @override
  List<Object> get props => [list];
}

class RemoveUserShareInitial extends RemoveUserShareState {
  RemoveUserShareInitial(List<UserShare> list) : super(list);
}

class LoadUserShare extends RemoveUserShareState {
  LoadUserShare(List<UserShare> list) : super(list);
}

class ResponseUserShare extends RemoveUserShareState {
  ResponseUserShare(List<UserShare> list) : super(list);
}
