import 'package:passmanager_diplom/domain/model/trash.dart';
import 'package:passmanager_diplom/domain/model/trash_data.dart';

abstract class TrashRepository {
  Future<List<TrashData>> index({required int userId});
  Future<bool> deleteAll({required int userId});
  Future<bool> restorationAll({required int userId});
  Future<bool> delete({required List<Trash> trash});
  Future<bool> restoration({required List<Trash> trash});
}
