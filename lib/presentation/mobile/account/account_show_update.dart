import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/domain/model/account.dart';
import 'package:passmanager_diplom/domain/state/account/account_cubit.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_filed.dart';

class AccountShowUpdate extends StatefulWidget {
  const AccountShowUpdate({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  State<AccountShowUpdate> createState() => _AccountShowUpdateState();
}

class _AccountShowUpdateState extends State<AccountShowUpdate> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AccountCubit>().init(widget.account);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Просмотр / Изменние аккаунта')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state is AccountSucces) {
              Navigator.pop(context);
            }
            if (_formKey.currentState!.validate()) {}
          },
          builder: (context, state) {
            return Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomField(
                        validation: (value) =>
                            context.read<AccountCubit>().valid == null
                                ? null
                                : context
                                    .read<AccountCubit>()
                                    .valid!
                                    .accountName,
                        controller: context.read<AccountCubit>().accountName,
                        labelText: 'Название учетной записи',
                        maxLength: 30,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      CustomField(
                        validation: (value) =>
                            context.read<AccountCubit>().valid == null
                                ? null
                                : context.read<AccountCubit>().valid!.login,
                        controller: context.read<AccountCubit>().login,
                        labelText: 'Логин',
                        maxLength: 30,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      CustomField(
                        validation: (value) =>
                            context.read<AccountCubit>().valid == null
                                ? null
                                : context.read<AccountCubit>().valid!.password,
                        controller: context.read<AccountCubit>().password,
                        labelText: 'Пароль',
                        maxLength: 30,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      CustomField(
                        controller: context.read<AccountCubit>().description,
                        labelText: 'Описание',
                        maxLength: 255,
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Row(
                  children: [
                    Expanded(child: Container()),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AccountCubit>().onCancel(widget.account);
                      },
                      child: const Text('Отмена'),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<AccountCubit>()
                            .accountUpdate(id: widget.account.id);
                      },
                      child: const Text('Сохранить'),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
