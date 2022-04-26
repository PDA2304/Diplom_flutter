import 'package:flutter/material.dart';

class FilesAdd extends StatefulWidget {
  const FilesAdd({ Key? key }) : super(key: key);

  @override
  State<FilesAdd> createState() => _FilesAddState();
}

class _FilesAddState extends State<FilesAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление файла'),
      ),
    );
  }
}