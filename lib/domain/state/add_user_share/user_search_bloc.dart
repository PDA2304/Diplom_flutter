import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/share_user.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final AuthRepository _repository;

  UserSearchBloc(this._repository)
      : super(UserSearchInitial(const <ShareUser>[], const <User>[])) {
    on<UserSearchEvent>(_search);
    on<CheckUserEvent>(_checkUser);
    on<RemoveCheckUserEvent>(_removeCheckUser);
    on<AddShareUserEvent>(_addShare);
  }

  void _search(UserSearchEvent event, Emitter<UserSearchState> emit) async {
    if (event is UserSearchLoad) {
      print('Load');
      emit(UserSearchLoad(state.list, state.listCheck));
    }

    if (event is RequestEvent) {
      print('Response');
      var list = await _repository.searchUser(
        typeTable: event.typeTable,
        search: event.search,
        dataId: event.dataId,
      );
      if (list.isNotEmpty)
        for (var item in state.listCheck) {
          list.firstWhere((element) => element.user.id == item.id).isChek =
              true;
        }

      emit(UserResponse(list, state.listCheck));
    }
  }

  void _removeCheckUser(
      RemoveCheckUserEvent event, Emitter<UserSearchState> emit) {
    var listCheck = state.listCheck.toList();
    listCheck.remove(event.user);
    emit(UserResponse(<ShareUser>[], listCheck));
  }

  void _checkUser(CheckUserEvent event, Emitter<UserSearchState> emit) {
    var list = state.list;
    var listCheck = state.listCheck.toList();
    var element = list.firstWhere((element) => element.user.id == event.id);
    element.isChek = event.check;

    event.check ? listCheck.add(element.user) : listCheck.remove(element.user);

    emit(UserResponse(list, listCheck));
  }

  void _addShare(AddShareUserEvent event, Emitter<UserSearchState> emit) async {
    List<int> userReceiver = [];

    state.listCheck.forEach((element) {
      userReceiver.add(element.id);
    });

    if (userReceiver.isEmpty) {
      emit(ShareError(
        const <ShareUser>[],
        state.listCheck,
        'Выберите пользователя',
      ));
      emit(UserSearchInitial(const <ShareUser>[], const <User>[]));
      return;
    }
    if (await _repository.addShareUser(
      dataId: event.dataId,
      userSenderId: event.userSenderId,
      typeTable: event.typeTable,
      userReceiver: userReceiver,
    )) {
      emit(ShareSucces(const <ShareUser>[], const <User>[]));
    } else {
      emit(ShareError(const <ShareUser>[], state.listCheck, 'Ошибка'));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
