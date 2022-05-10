import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/trash.dart';
import 'package:passmanager_diplom/domain/model/trash_data.dart';
import 'package:passmanager_diplom/domain/repository/trash_repository.dart';

class TrashDataRepository extends TrashRepository {
  final ApiUtil _apiUtil;

  TrashDataRepository(this._apiUtil);

  @override
  Future<bool> delete({required List<Trash> trash}) {
    return _apiUtil.deleteData(trash: trash);
  }

  @override
  Future<bool> deleteAll({required int userId}) {
    return _apiUtil.deleteAllData(userId: userId);
  }

  @override
  Future<List<TrashData>> index({required int userId}) {
    return _apiUtil.trashIndex(userId: userId);
  }

  @override
  Future<bool> restoration({required List<Trash> trash}) {
    return _apiUtil.restorationData(trash: trash);
  }

  @override
  Future<bool> restorationAll({required int userId}) {
    return _apiUtil.restorationAllData(userId: userId);
  }
}
