part of 'sing_in_cubit.dart';

@immutable
abstract class SingInState {}

class SingInInitial extends SingInState {}

class SingInLoad extends SingInState {}

class SingInResponce extends SingInState {
  final User user;
  final bool isSucces;

  SingInResponce({required this.user, required this.isSucces});
}
