import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';
import 'package:passmanager_diplom/domain/state/sing_up/sing_up_cubit.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  bool isObscure = true;
  String _userName = '';
  String _login = '';
  String _password = '';
  ValidationAuth _valid = ValidationAuth(
    userName: null,
    login: null,
    password: null,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, UrlPage.singIn, (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SingUpCubit, SingUpState>(
        listener: (context, state) {
          if (state.isSucces) {
            Navigator.pushNamed(context, UrlPage.confirmation,
                arguments: state.confirmation);
          }
          _valid = state.confirmation.validationAuth!;
          if (_formKey.currentState!.validate()) {}
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: Column(
              children: [
                const Text(
                  'Регистрация в PassManager',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                _form(),
                ((state) is SingUpLoad)
                    ? const CircularProgressIndicator()
                    : Container(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 35,
                          width: 250,
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                context.read<SingUpCubit>().singUp(
                                    userName: _userName,
                                    login: _login,
                                    password: _password);
                              },
                              child: const Text(
                                'Зарегистрироваться',
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _form() {
    return BlocBuilder<SingUpCubit, SingUpState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            TextFormField(
              onChanged: (value) => _userName = value,
              validator: (value) => _valid.userName,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                label: Text('Имя пользователя'),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
            TextFormField(
              onChanged: (value) => _login = value,
              validator: (value) => _valid.login,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                label: Text('Почта пользователя'),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
            TextFormField(
              onChanged: (value) => _password = value,
              validator: (value) => _valid.password,
              obscureText: isObscure,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onLongPressUp: () {
                    setState(() {
                      isObscure = true;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      isObscure = false;
                    });
                  },
                  onTap: () {},
                  child: isObscure
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                border: const OutlineInputBorder(),
                label: const Text('Пароль'),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
          ]),
        );
      },
    );
  }
}
