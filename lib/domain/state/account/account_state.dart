part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoad extends AccountState {}

class AccountCreate extends AccountState {
  final Account account;

  AccountCreate(this.account);
}

class AccountUpdate extends AccountState {
  final Account account;

  AccountUpdate(this.account);
}

class AccountSucces extends AccountState {}

class AccountCancel extends AccountState {}
