import 'package:passmanager_diplom/domain/model/account.dart';

abstract class CRUDAccountRepository {
  Future<Account> create({
    required String accountName,
    required String login,
    required String password,
    required String description,
    required int userId,
  });
  Future<Account> update({
    required int id,
    required String accountName,
    required String login,
    required String password,
    required String description,
  });
  Future<List<Account>> index({required int userId});
  Future<Account> logicDelete();
}
