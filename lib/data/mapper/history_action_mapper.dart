import 'package:passmanager_diplom/data/api/model/api_history_action.dart';
import 'package:passmanager_diplom/domain/model/history_action.dart';

class HistoryActionMapper {
  static HistoryAction fromApi({required ApiHistoryAction apiModel}) =>
      HistoryAction(
        userId: apiModel.userId,
        userName: apiModel.userName,
        typeAction: apiModel.typeAction,
        actionDate: apiModel.actionDate,
      );
}
