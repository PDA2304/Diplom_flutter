import 'package:passmanager_diplom/data/api/model/api_validatio_new_user_name.dart';
import 'package:passmanager_diplom/domain/model/validation_new_user_name.dart';

class ValidationNewUserNameMapper {
  static ValidationNewUserName fromApi(ApiValidationNewUserName? model) {
    return model == null
        ? ValidationNewUserName(userName: null)
        : ValidationNewUserName(
            userName: model.userName!.isEmpty ? null : model.userName!.first);
  }
}
