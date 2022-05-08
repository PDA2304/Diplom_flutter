import 'package:passmanager_diplom/constant/type_table.dart';

class ApiData {
  final int id;
  final String name;
  final String createAt;
  final bool isCreator;
  final TypeTable typeTable;

  ApiData.fromApi(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        createAt = json['created_at'] ?? DateTime.now().toIso8601String(),
        isCreator = json['creator'] ?? true,
        typeTable = TypeTable.values[json['type_table'] ?? 0];

  static List<ApiData> fromApiList(dynamic jsonList) =>
      (jsonList as List).map((e) => ApiData.fromApi(e)).toList();
}
