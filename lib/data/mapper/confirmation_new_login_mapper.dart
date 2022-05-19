import 'package:passmanager_diplom/data/api/model/api_confirmation_new_login.dart';
import 'package:passmanager_diplom/data/mapper/validation_new_login_mapper.dart';
import 'package:passmanager_diplom/domain/model/confirmation_new_login.dart';

class ConfirmatioNewLoginMapper {
  static ConfirmationNewLogin fromApi(ApiConfirmationNewLogin model) {
    return ConfirmationNewLogin(
      number: model.number,
      validationNewLogin: ValidationNewLoginMapper.fromApi(
        model: model.validationNewLogin,
      ),
    );
  }
}
