import 'package:passmanager_diplom/constant/type_table.dart';

class RequestRemoveShareUser {
  final int dataId;
  final TypeTable typeTable;
  final int userSenderId;
  final int userReceiverId;

  RequestRemoveShareUser(
    this.dataId,
    this.typeTable,
    this.userSenderId,
    this.userReceiverId,
  );

  Map<String, dynamic> toApi() {
    return {
      'data_id': dataId,
      'user_sender_id': userSenderId,
      'type_table': typeTable.index + 1,
      'user_receiver_id': userReceiverId
    };
  }
}
