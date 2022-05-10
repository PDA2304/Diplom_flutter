import 'package:passmanager_diplom/constant/type_table.dart';

class TrashData {
  final int id;
  final String name;
  final DateTime createAt;
  final bool isCreator;
  final TypeTable typeTable;
  bool isCheck;

  TrashData({
    required this.id,
    required this.name,
    required this.createAt,
    required this.isCreator,
    required this.typeTable,
    this.isCheck = false,
  });
}
