import 'dart:convert';

import 'package:passmanager_diplom/constant/type_table.dart';

class RequestAddShareUser {
  final int dataId;
  final int userSenderId;
  final TypeTable typeTable;
  final List<int> userReceiver;

  RequestAddShareUser(
    this.dataId,
    this.userSenderId,
    this.typeTable,
    this.userReceiver,
  );

  Map<String, dynamic> toApi() {
    return {
      'data_id': dataId,
      'user_sender_id': userSenderId,
      'type_table': typeTable.index + 1,
      'user_receiver': userReceiver,
    };
  }
}
