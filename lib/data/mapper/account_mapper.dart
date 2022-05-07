import 'package:passmanager_diplom/data/api/model/api_account.dart';
import 'package:passmanager_diplom/data/mapper/validation_account_mapper.dart';
import 'package:passmanager_diplom/domain/model/account.dart';

class AccountMapper {
  static Account fromApi({required ApiAccount account}) {
    return Account(
      id: account.id!,
      accountName: account.accountName!,
      login: account.login!,
      password: account.password!,
      description: account.description!,
      createAt: DateTime.parse(account.createAt!).toLocal(),
      isCreator: account.isCreator!,
      userId: account.userId!,
      validationAccount: account.validAccount == null
          ? null
          : ValidationAccountMapper.fropApi(account.validAccount),
    );
  }
}
