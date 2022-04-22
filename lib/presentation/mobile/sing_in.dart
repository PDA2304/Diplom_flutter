import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Вход в PassManager',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  label: Text('Почта пользователя'),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
              TextFormField(
                obscureText: isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
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
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: SizedBox(
                  width: 200,
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () => print('Вход в систему'),
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
                  onPressed: () => Navigator.pushNamed(context, UrlPage.singUp),
                  child: const Text(
                    'Регистрация',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
