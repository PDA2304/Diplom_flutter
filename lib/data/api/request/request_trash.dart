class RequestTrash {
  final int id;
  final int typeTable;

  RequestTrash(this.id, this.typeTable);

  Map<String, dynamic> toJson() => {
        'id': id,
        'type_table': typeTable,
      };
}
