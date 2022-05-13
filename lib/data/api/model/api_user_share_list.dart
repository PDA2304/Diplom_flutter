import 'package:passmanager_diplom/data/api/model/api_user_share.dart';

class ApiUserShareList {
  final List<ApiUserShare> list;

  ApiUserShareList.fromApi(dynamic json)
      : list = (json as List).map((e) => ApiUserShare.fromApi(e)).toList();
}
