import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:passmanager_diplom/constant/type_extensions.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_file.dart';
import 'package:passmanager_diplom/domain/state/files/files_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/generate_color.dart';

class FilesAdd extends StatefulWidget {
  const FilesAdd({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<FilesAdd> createState() => _FilesAddState();
}

class _FilesAddState extends State<FilesAdd> {
  final _formKey = GlobalKey<FormState>();
  ValidationFile? _valid = ValidationFile.empty();
  String fileName = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление файла'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<FilesCubit, FilesState>(
          listener: (context, state) {
            if (state is FilesErorr) {
              _valid = state.files.validationFile;
              if (state.files.validationFile!.file != null) {
                print(state.files.validationFile!.file!);
                _fileErorrSnakBar(state.files.validationFile!.file!);
              }
              if (_formKey.currentState!.validate()) {}
            }
            if (state is FilesResponse) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Column(children: [
              _form(),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    print(fileName);
                    context
                        .read<FilesCubit>()
                        .filesCreate(fileName, description, widget.user);
                  },
                  child: const Text('Сохранить'),
                ),
              ),
              const SizedBox(height: 15),
              context.read<FilesCubit>().isCheckFile
                  ? (TypeExtension.extensions.indexWhere((element) =>
                              element ==
                              context.read<FilesCubit>().fileExtensions) <=
                          4
                      ? _imageContainer(context.read<FilesCubit>().file.path)
                      : _fileContainer(context.read<FilesCubit>().file.path))
                  : Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<FilesCubit>().selectFile();
                        },
                        child: const Text('Выбрать файл'),
                      ),
                    ),
            ]);
          },
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          validator: (value) => _valid == null ? null : _valid!.fileName,
          onChanged: (value) => fileName = value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Название файла',
            label: Text('Название файла'),
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          onChanged: (value) => description = value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Описание',
            label: Text('Описание'),
          ),
          minLines: 1,
          maxLines: 3,
          maxLength: 512,
        ),
      ]),
    );
  }

  Widget _fileContainer(String filePath) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        context.read<FilesCubit>().fileOpen();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: GenerateColor.generateExtension(
              context.read<FilesCubit>().fileExtensions),
        ),
        width: 150,
        height: 100,
        child: Tooltip(
          message: 'Нажмите для предпросмотра файла',
          child: Stack(
            children: [
              Positioned(
                top: 1,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      context.read<FilesCubit>().isCheckFile = false;
                      context.read<FilesCubit>().file = File('');
                    });
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  ".${context.read<FilesCubit>().fileExtensions}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContainer(String filePath) {
    return Expanded(
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              OpenFile.open(filePath);
            },
            child: Image.file(
              context.read<FilesCubit>().file,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 1,
            right: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  context.read<FilesCubit>().isCheckFile = false;
                  context.read<FilesCubit>().file = File('');
                });
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _fileErorrSnakBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
