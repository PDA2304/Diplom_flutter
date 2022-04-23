import 'package:passmanager_diplom/data/api/model/api_confirmation.dart';
import 'package:passmanager_diplom/data/api/request/request_confirmation.dart';
import 'package:passmanager_diplom/data/mapper/validation_mapper.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart';

class ConfirmationMapper {
  static Confirmation fropApi(
      {required ApiConfirmation confirmation,
      required RequestConfirmation user}) {
    return Confirmation(
      number: confirmation.number!,
      userName: user.userName,
      login: user.login,
      password: user.password,
      validationAuth: ValidationAuthMapper.fropApi(confirmation.validatioAuth!),
    );
  }
}
