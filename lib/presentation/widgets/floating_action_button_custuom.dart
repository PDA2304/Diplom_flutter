import 'package:flutter/material.dart';

class FloatingActionButtonCutom extends StatefulWidget {
  const FloatingActionButtonCutom({Key? key}) : super(key: key);

  @override
  State<FloatingActionButtonCutom> createState() =>
      _FloatingActionButtonCutom();
}

class _FloatingActionButtonCutom extends State<FloatingActionButtonCutom> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (ctx) => Wrap(
            children: [
              ListTile(
                title: const Text('Аккаунты'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Файл'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Заметки'),
                onTap: () {},
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
