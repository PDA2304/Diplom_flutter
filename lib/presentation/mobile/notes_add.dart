import 'package:flutter/material.dart';

class NotesAdd extends StatefulWidget {
  const NotesAdd({Key? key}) : super(key: key);

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление заметки'),
      ),
    );
  }
}
