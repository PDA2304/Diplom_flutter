import 'package:equatable/equatable.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

class ShareUser extends Equatable {
  final User user;
  bool isChek;

  ShareUser({
    required this.user,
    this.isChek = false,
  });

  @override
  List<Object?> get props => [user, isChek];
}
