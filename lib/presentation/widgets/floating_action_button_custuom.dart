import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/user.dart';

class FloatingActionButtonCutom extends StatefulWidget {
  const FloatingActionButtonCutom({Key? key, required this.user})
      : super(key: key);
  final User user;

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
                  Navigator.pushNamed(
                    context,
                    UrlPage.accountAdd,
                    arguments: widget.user.id,
                  );
                },
              ),
              ListTile(
                title: const Text('Файл'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    UrlPage.filesAdd,
                    arguments: widget.user,
                  );
                },
              ),
              ListTile(
                title: const Text('Заметки'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    UrlPage.notesAdd,
                    arguments: widget.user.id,
                  );
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
