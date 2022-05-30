import 'package:passmanager_diplom/data/api/model/api_file.dart';

class ApiFileList {
  final List<ApiFile> list;

  ApiFileList.fromApi(dynamic jsonList)
      : list = (jsonList as List).map((e) => ApiFile.fromApi(e)).toList();
}
