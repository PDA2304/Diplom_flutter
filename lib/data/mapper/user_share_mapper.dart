import 'package:passmanager_diplom/data/api/model/api_user_share.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';

class UserShareMapper {
  static UserShare fromApi({required ApiUserShare apiModel}) {
    return UserShare(
      userId: apiModel.userId,
      userLogin: apiModel.userLogin,
      userName: apiModel.userName,
      createdShare: DateTime.parse(apiModel.createdShare).toLocal(),
    );
  }
}
