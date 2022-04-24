import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';
import 'package:passmanager_diplom/domain/repository/crud_reposittiry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CRUDDataRepository extends CRUDRepository {
  SharedPreferences? _preferences;

  @override
  void create({required User user}) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences!.setInt('id', user.id);
    _preferences!.setString('userName', user.userName);
    _preferences!.setString('email', user.email);
  }

  @override
  void delete() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences!.clear();
  }

  @override
  Future<User> read() async {
    _preferences = await SharedPreferences.getInstance();

    return User(
        id: _preferences!.getInt('id') ?? 0,
        userName: _preferences!.getString('userName') ?? '',
        email: _preferences!.getString('email') ?? '',
        validationAuth:
            ValidationAuth(login: null, password: null, userName: null));
  }

  @override
  void update() {
    // TODO: implement update
  }
}
