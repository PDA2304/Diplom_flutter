import 'dart:convert';

import 'package:passmanager_diplom/data/api/request/request_trash.dart';

class RequestTrashList {
  final List<RequestTrash> trash;

  RequestTrashList(this.trash);

  String toApi() => jsonEncode(trash);
}
