import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/data.dart';
import 'package:passmanager_diplom/domain/repository/data_repository.dart';

class DataDataRepository extends DataRepository {
  final ApiUtil _apiUtil;

  DataDataRepository(this._apiUtil);

  @override
  Future<List<Data>> index({required int userId}) =>
      _apiUtil.dataIndex(userId: userId);
}
