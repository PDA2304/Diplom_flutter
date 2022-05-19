import 'package:passmanager_diplom/data/api/model/api_validation_new_login.dart';
import 'package:passmanager_diplom/domain/model/validation_new_login.dart';

class ValidationNewLoginMapper {
  static ValidationNewLogin fromApi({required ApiValidationNewLogin? model}) {
    return model == null
        ? ValidationNewLogin(login: null)
        : ValidationNewLogin(
            login: model.login!.isEmpty ? null : model.login!.first,
          );
  }
}
