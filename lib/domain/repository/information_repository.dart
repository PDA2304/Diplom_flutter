import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/data_information.dart';
import 'package:passmanager_diplom/domain/model/history_action.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';

abstract class InformationRepository {
  Future<List<HistoryAction>> indexhistoryAction({
    required int userId,
    required dataId,
    required TypeTable typeTable,
  });
  Future<List<UserShare>> indexUserShare({
    required int userId,
    required dataId,
    required TypeTable typeTable,
  });
  Future<DataInformation> indexDataInformation({
    required int dataId,
    required TypeTable typeTable,
  });
}
