import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/data_information.dart';
import 'package:passmanager_diplom/domain/model/history_action.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';
import 'package:passmanager_diplom/domain/repository/information_repository.dart';

class InformationDataRepository extends InformationRepository {
  final ApiUtil _apiUtil;

  InformationDataRepository(this._apiUtil);

  @override
  Future<DataInformation> indexDataInformation({
    required int dataId,
    required TypeTable typeTable,
  }) {
    return _apiUtil.indexDataInformation(dataId: dataId, typeTable: typeTable);
  }

  @override
  Future<List<UserShare>> indexUserShare({
    required int userId,
    required dataId,
    required TypeTable typeTable,
  }) {
    return _apiUtil.indexUserShare(
      userId: userId,
      dataId: dataId,
      typeTable: typeTable,
    );
  }

  @override
  Future<List<HistoryAction>> indexhistoryAction({
    required int userId,
    required dataId,
    required TypeTable typeTable,
  }) {
    return _apiUtil.indexHistoryAction(
      userId: userId,
      dataId: dataId,
      typeTable: typeTable,
    );
  }
}
