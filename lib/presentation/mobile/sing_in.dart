import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              'Вход в PassManager',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
            const Text(
              'Используйте один аккаунт, чтобы управлять защитой всех ващих ващих устройств.',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 7.5)),
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
                suffixIcon: InkWell(
                  onFocusChange: (value) {},
                  onHover: (value) {
                    setState(() {
                      isObscure = !value;
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
            Container(
              alignment: AlignmentDirectional.centerEnd,
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
            const Padding(
                padding: EdgeInsets.symmetric(
              vertical: 7.5,
              horizontal: 10,
            )),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                width: 200,
                height: 30,
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
                onPressed: () => print('Регистрация пользователя'),
                child: const Text(
                  'Регистрация',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
