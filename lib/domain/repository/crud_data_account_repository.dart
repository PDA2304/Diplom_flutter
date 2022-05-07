import 'package:passmanager_diplom/data/api/api_util.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/repository/crud_account_repository.dart';

class CRUDDataAccountRepository extends CRUDAccountRepository {
  final ApiUtil _apiUtil;
  CRUDDataAccountRepository(this._apiUtil);

  @override
  Future<Account> create({
    required String accountName,
    required String login,
    required String password,
    required String description,
    required int userId,
  }) {
    return _apiUtil.accountCreate(
        accountName: accountName,
        login: login,
        password: password,
        description: description,
        userId: userId);
  }

  @override
  Future<List<Account>> index({required int userId}) {
    return _apiUtil.accountIndex(userId: userId);
  }

  @override
  Future<Account> logicDelete() {
    // TODO: implement logicDelete
    throw UnimplementedError();
  }

  @override
  Future<Account> update({
    required int id,
    required String accountName,
    required String login,
    required String password,
    required String description,
  }) {
    return _apiUtil.accountUpdate(
      id: id,
      accountName: accountName,
      login: login,
      password: password,
      description: description,
    );
  }
}
