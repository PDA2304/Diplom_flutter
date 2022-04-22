import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  bool isObscure = true;

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              'Регистрация в PassManager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                label: Text('Имя пользователя'),
              ),
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
            Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 35,
                width: 250,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, UrlPage.confirmation);
                    },
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
