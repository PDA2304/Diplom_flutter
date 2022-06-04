import 'package:equatable/equatable.dart';

class UserShare extends Equatable {
  final int userId;
  final String userLogin;
  final String userName;
  final DateTime createdShare;

  UserShare({
    required this.userId,
    required this.userLogin,
    required this.userName,
    required this.createdShare,
  });

  @override
  List<Object?> get props => [userId, userLogin, userName, createdShare];
}
