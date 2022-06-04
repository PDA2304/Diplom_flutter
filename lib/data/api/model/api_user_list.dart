import 'package:passmanager_diplom/data/api/model/api_user.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

class ApiUserList {
  final List<ApiUser> list;

  ApiUserList.fromApi(dynamic json)
      : list = (json as List).map((e) => ApiUser.fromApi(e)).toList();
}
