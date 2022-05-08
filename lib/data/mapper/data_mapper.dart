import 'package:passmanager_diplom/data/api/model/api_data.dart';
import 'package:passmanager_diplom/domain/model/data.dart';

class DataMapper {
  static Data fromApi({required ApiData data}) {
    return Data(
      id: data.id,
      name: data.name,
      createAt:  DateTime.parse(data.createAt).toLocal(),
      isCreator: data.isCreator,
      typeTable: data.typeTable,
    );
  }
}
