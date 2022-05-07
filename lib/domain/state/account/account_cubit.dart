import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/model/validation_account.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._dataCubit) : super(AccountInitial());

  final DataCubit _dataCubit;

  TextEditingController accountName = TextEditingController();
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController description = TextEditingController();
  ValidationAccount? valid;

  void accountCreate({
    required String accountName,
    required String login,
    required String password,
    required String description,
    required int userId,
  }) async {
    emit(AccountLoad());
    var account = await _dataCubit.crudAccountRepository.create(
      accountName: accountName,
      login: login,
      password: password,
      description: description,
      userId: userId,
    );

    if (account.validationAccount == null) {
      _dataCubit.addAccount(account);
      emit(AccountSucces());
    } else {
      emit(AccountCreate(account));
    }
  }

  void accountUpdate({required int id}) async {
    emit(AccountLoad());
    var account = await _dataCubit.crudAccountRepository.update(
      id: id,
      accountName: accountName.text,
      login: login.text,
      password: password.text,
      description: description.text,
    );

    if (account.validationAccount == null) {
      _dataCubit.updateAccount(account);
      emit(AccountSucces());
    } else {
      valid = account.validationAccount;
      emit(AccountUpdate(account));
    }
  }

  void onCancel(Account account) {
    accountName.text = account.accountName;
    login.text = account.login;
    password.text = account.password;
    description.text = account.description;
    emit(AccountCancel());
  }

  void init(Account account) {
    accountName.text = account.accountName;
    login.text = account.login;
    password.text = account.password;
    description.text = account.description;
  }
}
