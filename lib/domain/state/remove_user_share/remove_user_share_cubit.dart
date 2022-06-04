import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';
import 'package:passmanager_diplom/domain/state/data_description/data_information_cubit.dart';
import 'package:passmanager_diplom/presentation/mobile/data_description.dart';

part 'remove_user_share_state.dart';

class RemoveUserShareCubit extends Cubit<RemoveUserShareState> {
  RemoveUserShareCubit(this._repository, this._dataDescription)
      : super(RemoveUserShareInitial(const <UserShare>[]));

  final AuthRepository _repository;
  final DataDescriptionCubit _dataDescription;

  void init(List<UserShare> list) => emit(RemoveUserShareInitial(list));

  void remove(
    int dataId,
    TypeTable typeTable,
    int userSenderId,
    int userReceiverId,
  ) async {
    var list = state.list.toList();

    emit(LoadUserShare(list));

    var response = await _repository.removeShareUser(
      dataId: dataId,
      userSenderId: userSenderId,
      typeTable: typeTable,
      userReceiverId: userReceiverId,
    );

    if (response) {
      list.removeWhere((element) => element.userId == userReceiverId);
      _dataDescription.removeShareUser(userReceiverId);
      emit(ResponseUserShare(list));
    } else {}
  }
}
