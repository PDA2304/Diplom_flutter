import 'package:passmanager_diplom/data/api/model/api_account.dart';

class ApiAccountList {
  final List<ApiAccount> accountList;

  ApiAccountList.fromApi(dynamic jsonList)
      : accountList = (jsonList as List).map((e) => ApiAccount.fromApi(e)).toList();
}
