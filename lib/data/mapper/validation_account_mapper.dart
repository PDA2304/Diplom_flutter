import 'package:passmanager_diplom/data/api/model/api_validation_account.dart';
import 'package:passmanager_diplom/domain/model/validation_account.dart';

class ValidationAccountMapper {
  static ValidationAccount fropApi(ApiValidationAccount? valid) {
    return valid == null
        ? ValidationAccount(
            accountName: null,
            login: null,
            password: null,
          )
        : ValidationAccount(
            accountName:
                valid.accountName.isEmpty ? null : valid.accountName.first,
            login: valid.login.isEmpty ? null : valid.login.first,
            password: valid.password.isEmpty ? null : valid.password.first,
          );
  }
}
