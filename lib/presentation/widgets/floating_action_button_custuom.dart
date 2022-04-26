import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';

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
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, UrlPage.accountAdd);
                },
              ),
              ListTile(
                title: const Text('Файл'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, UrlPage.filesAdd);
                },
              ),
              ListTile(
                title: const Text('Заметки'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, UrlPage.notesAdd);
                },
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
