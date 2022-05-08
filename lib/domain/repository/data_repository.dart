import 'package:passmanager_diplom/domain/model/data.dart';

abstract class DataRepository {
  Future<List<Data>> index({required int userId});
}
