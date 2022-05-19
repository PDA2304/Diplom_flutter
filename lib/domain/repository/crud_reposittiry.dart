import 'package:passmanager_diplom/domain/model/user.dart';

abstract class CRUDRepository {
  void create({required User user});
  Future<User> read();
  void update(String key, String content);
  void delete();
}
