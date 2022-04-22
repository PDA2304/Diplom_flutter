import 'package:meta/meta.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';

class User {
  final int id;
  final String userName;
  final String email;
  final ValidationAuth validationAuth;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.validationAuth,
  });
}
