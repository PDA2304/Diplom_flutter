import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';
import 'package:passmanager_diplom/domain/state/sing_in/sing_in_cubit.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  bool _isObscure = true;
  String _login = '';
  String _password = '';
  ValidationAuth _validationAuth = ValidationAuth(
    userName: null,
    login: null,
    password: null,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<SingInCubit, SingInState>(
            listener: (context, state) {
              if (state is SingInResponce) {
                if (state.isSucces) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, UrlPage.home, (route) => false);
                }
                _validationAuth = state.user.validationAuth;
                if (_formKey.currentState!.validate()) {}
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Вход в PassManager',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Используйте один аккаунт, чтобы управлять защитой всех ващих ващих устройств.',
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _from(),
                  (state is SingInLoad)
                      ? const CircularProgressIndicator()
                      : Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: SizedBox(
                            width: 200,
                            height: 35,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () => context
                                  .read<SingInCubit>()
                                  .SingIn(login: _login, password: _password),
                              child: const Text(
                                'Вход',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                  Expanded(child: Container()),
                  SizedBox(
                    height: 35,
                    width: 250,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, UrlPage.singUp),
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _from() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) => _validationAuth.login,
            onChanged: (value) => _login = value,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
              label: Text('Почта пользователя'),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
          TextFormField(
            validator: (value) => _validationAuth.password,
            onChanged: (value) => _password = value,
            obscureText: _isObscure,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
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
              border: const OutlineInputBorder(),
              label: const Text('Пароль'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                onTap: () {
                  print('Восстановление входа');
                },
                child: const Text(
                  'Забыли пароль ?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
