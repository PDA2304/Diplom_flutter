import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/domain/model/validation_account.dart';
import 'package:passmanager_diplom/domain/state/account/account_cubit.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<AccountAdd> createState() => _AccountAddState();
}

class _AccountAddState extends State<AccountAdd> {
  final _formKey = GlobalKey<FormState>();
  ValidationAccount? _valid;
  bool _isObscure = true;
  String _accountName = '';
  String _login = '';
  String _password = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление аккаунта'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state is AccountCreate) {
              _valid = state.account.validationAccount;
              if (_formKey.currentState!.validate()) {}
            }
            if (state is AccountSucces) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _form(),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                (state is AccountLoad)
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AccountCubit>().accountCreate(
                                  accountName: _accountName,
                                  login: _login,
                                  password: _password,
                                  description: _description,
                                  userId: widget.userId,
                                );
                          },
                          child: const Text('Добавить'),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) => _valid == null ? null : _valid!.accountName,
            onChanged: (value) => _accountName = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'ВК',
              label: Text('Название учетной записи'),
            ),
            maxLength: 30,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            validator: (value) => _valid == null ? null : _valid!.login,
            onChanged: (value) => _login = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'isip_d.a.pahomov@mpt.ru',
              label: Text('Логин'),
            ),
            maxLength: 30,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            validator: (value) => _valid == null ? null : _valid!.password,
            onChanged: (value) => _password = value,
            obscureText: _isObscure,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('Пароль'),
              suffixIcon: GestureDetector(
                onLongPressUp: () {
                  setState(() {
                    _isObscure = true;
                  });
                },
                onLongPress: () {
                  setState(() {
                    _isObscure = false;
                  });
                },
                onTap: () {},
                child: _isObscure
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
            ),
            maxLength: 30,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            onChanged: (value) => _description = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Данные от учетный записи социальной сети вк',
              label: Text('Описание'),
            ),
            maxLength: 30,
          ),
        ],
      ),
    );
  }
}
