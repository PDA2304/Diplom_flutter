import 'package:flutter/material.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({Key? key}) : super(key: key);

  @override
  State<AccountAdd> createState() => _AccountAddState();
}

class _AccountAddState extends State<AccountAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление аккаунта'),
      ),
    );
  }
}
