// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:passmanager_diplom/constant/type_table.dart';

class RequestSearchUser {
  final TypeTable typeTable;
  final String search;
  final int dataId;

  RequestSearchUser(
      {required this.typeTable, required this.search, required this.dataId});

  Map<String, dynamic> toApi() {
    return {
      'type_table': typeTable.index + 1,
      'search': search,
      'data_id': dataId,
    };
  }
}
