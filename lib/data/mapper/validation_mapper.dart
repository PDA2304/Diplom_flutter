import 'package:passmanager_diplom/data/api/model/api_user.dart';
import 'package:passmanager_diplom/data/api/model/api_validation_auth.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';

class ValidationAuthMapper {
  static ValidationAuth fropApi(ApiValidationAuth validAuth) {
    return ValidationAuth(
      userName: validAuth.userName!.isEmpty ? '' : validAuth.userName!.first,
      login: validAuth.login!.isEmpty ? '' : validAuth.login!.first,
      password: validAuth.password!.isEmpty ? '' : validAuth.password!.first,
    );
  }
}
