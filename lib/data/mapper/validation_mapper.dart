import 'package:passmanager_diplom/data/api/model/api_validation_auth.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';

class ValidationAuthMapper {
  static ValidationAuth fropApi(ApiValidationAuth validAuth) {
    return ValidationAuth(
      userName: validAuth.userName!.isEmpty ? null : validAuth.userName!.first,
      login: validAuth.login!.isEmpty ? null : validAuth.login!.first,
      password: validAuth.password!.isEmpty ? null : validAuth.password!.first,
    );
  }
}
