import '../../constant/type_table.dart';

class Data {
  final int id;
  final String name;
  final DateTime createAt;
  final bool isCreator;
  final TypeTable typeTable;

  Data({
    required this.id,
    required this.name,
    required this.createAt,
    required this.isCreator,
    required this.typeTable,
  });
}
