import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/data_information.dart';
import 'package:passmanager_diplom/domain/model/history_action.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';
import 'package:passmanager_diplom/domain/repository/information_repository.dart';

part 'data_information_state.dart';

class DataDescriptionCubit extends Cubit<DataDescriptionState> {
  DataDescriptionCubit(this._informationRepository)
      : super(DataDescriptionInitial(const <HistoryAction>[],
            const <UserShare>[], DataInformation.dataEmpty()));

  final InformationRepository _informationRepository;

  void init({required int dataId, required TypeTable typeTable}) async {
    _informationRepository
        .indexDataInformation(dataId: dataId, typeTable: typeTable)
        .then((value) {
      emit(DataDescriptionResponse(
          state.historyActionList, state.userShareList, value));

      _informationRepository
          .indexUserShare(
              userId: value.userId, dataId: dataId, typeTable: typeTable)
          .then((value) {
        state.isSuccesUserShare = true;
        emit(DataDescriptionResponse(
            state.historyActionList, value, state.dataInformation));
      });
      _informationRepository
          .indexhistoryAction(
              userId: value.userId, dataId: dataId, typeTable: typeTable)
          .then((value) {
        state.isSuccesHistoryAction = true;
        emit(DataDescriptionResponse(
            value, state.userShareList, state.dataInformation));
      });
    });
  }
}
