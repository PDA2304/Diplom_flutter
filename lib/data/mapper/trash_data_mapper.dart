import 'package:passmanager_diplom/data/api/model/api_data.dart';
import 'package:passmanager_diplom/domain/model/trash_data.dart';

class TrashDataMapper {
  static TrashData fromApi({required ApiData data}) {
    return TrashData(
      id: data.id,
      name: data.name,
      createAt:  DateTime.parse(data.createAt).toLocal(),
      isCreator: data.isCreator,
      typeTable: data.typeTable,
    );
  }
}
