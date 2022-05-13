class RequestInfromation {
  final int userId;
  final int dataId;
  final int typeTableId;

  RequestInfromation({
    this.userId = 0,
    required this.dataId,
    required this.typeTableId,
  });

  Map<String, dynamic> toApiUserShare() => {
        'user_id': userId,
        'data_id': dataId,
        'type_table_id': typeTableId,
      };

  Map<String, dynamic> toApiHistoryAction() => {
        'user_id': userId,
        'data_id': dataId,
        'type_table_id': typeTableId + 1,
      };

  Map<String, dynamic> toApiDataInformation() => {
        'data_id': dataId,
        'type_table_id': typeTableId,
      };
}
