// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';

class User extends Equatable {
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

  @override
  List<Object> get props => [id, userName, email];
}
