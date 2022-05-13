import 'package:passmanager_diplom/data/api/model/api_history_action.dart';

class ApiHistoryActionList {
  final List<ApiHistoryAction> list;

  ApiHistoryActionList.fromApi(dynamic json)
      : list = (json as List).map((e) => ApiHistoryAction.fromApi(e)).toList();
}
