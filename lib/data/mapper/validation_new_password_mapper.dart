import 'package:passmanager_diplom/data/api/model/api_validation_new_password.dart';
import 'package:passmanager_diplom/domain/model/validation_new_password.dart';

class ValidationNewPasswordMapper {
  static ValidationNewPassword fromApi(ApiValidationNewPassword? model) {
    return model == null
        ? ValidationNewPassword(newPassword: null, oldPassword: null)
        : ValidationNewPassword(
            newPassword:
                model.newPassword!.isEmpty ? null : model.newPassword!.first,
            oldPassword:
                model.oldPassword!.isEmpty ? null : model.oldPassword!.first,
          );
  }
}
