import 'package:passmanager_diplom/data/api/model/api_user.dart';
import 'package:passmanager_diplom/data/mapper/validation_mapper.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

class UserMapper {
  static User fropApi(ApiUser user) {
    return User(
      id: user.id!,
      userName: user.userName!,
      email: user.email!,
      validationAuth: ValidationAuthMapper.fropApi(user.validAuth)
    );
  }
}
