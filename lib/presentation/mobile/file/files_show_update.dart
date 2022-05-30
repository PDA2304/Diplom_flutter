import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/type_extensions.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/files.dart';
import 'package:passmanager_diplom/domain/model/validation_file.dart';
import 'package:passmanager_diplom/domain/state/files/files_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/generate_color.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_filed.dart';
import 'package:passmanager_diplom/presentation/widgets/data_action.dart';

class FilesShowUpdate extends StatefulWidget {
  const FilesShowUpdate({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  State<FilesShowUpdate> createState() => _FilesShowUpdateState();
}

class _FilesShowUpdateState extends State<FilesShowUpdate> {
  final _formKey = GlobalKey<FormState>();
  FilesCubit? _cubit;
  String dowloadIndicator = '';
  double value = 0;
  ValidationFile? _valid;

  @override
  void initState() {
    _cubit = BlocProvider.of<FilesCubit>(context);
    _cubit!.init(widget.file);

    super.initState();
  }

  @override
  void dispose() {
    _cubit!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Просмотр / Редактирование файла'),
        centerTitle: true,
        actions: [
          DataAction(onSelected: (item) {
            switch (item) {
              case 0:
                {
                  Navigator.pushNamed(context, UrlPage.dataDescription,
                      arguments: [
                        widget.file.id,
                        TypeTable.files,
                      ]);
                  break;
                }
              case 1:
                {
                  break;
                }
              case 2:
                {
                  _cubit!.filesDelete(id: widget.file.id);
                  Navigator.pop(context);
                  break;
                }
              default:
                {
                  break;
                }
            }
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocListener<FilesCubit, FilesState>(
          listener: (context, state) {
            if (state is FilesErorr) {
              _valid = state.files.validationFile;
              if (state.files.validationFile!.file != null) {
                _fileErorrSnakBar(state.files.validationFile!.file!);
              }
              if (_formKey.currentState!.validate()) {}
            }
            if (state is FilesResponse) {
              Navigator.pop(context);
            }
            setState(() {
              dowloadIndicator = _cubit!.dowloadIndicator;
              value = _cubit!.process;
              print(value);
            });
          },
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomField(
                    validation: (value) => value = _valid!.fileName,
                    controller: _cubit!.filesNameController,
                    labelText: 'Название файла',
                  ),
                  Container(height: 15),
                  CustomField(
                    controller: _cubit!.descriptionController,
                    labelText: 'Описание',
                  ),
                ],
              ),
            ),
            Container(height: 15),
            Row(
              children: [
                Expanded(child: Container()),
                ElevatedButton(
                  onPressed: () {
                    _cubit!.cancel(widget.file);
                  },
                  child: Text('Отмена'),
                ),
                Container(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    _cubit!.update(widget.file);
                  },
                  child: Text('Сохранить'),
                ),
              ],
            ),
            Container(height: 15),
            _cubit!.isCheckFile
                ? _cubit!.isDowload
                    ? (TypeExtension.extensions.indexWhere((element) =>
                                element ==
                                context.read<FilesCubit>().fileExtensions) <=
                            4
                        ? _imageContainer(context.read<FilesCubit>().file.path)
                        : _fileContainer(context.read<FilesCubit>().file.path))
                    : Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[350]!),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 75,
                                height: 75,
                                child: CircularProgressIndicator(
                                  value: value,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green[400]!),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(dowloadIndicator),
                          ),
                        ]),
                      )
                : ElevatedButton(
                    onPressed: () {
                      _cubit!.selectFile();
                    },
                    child: Text('Выбрать файл'))
          ]),
        ),
      ),
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
                      _cubit!.isCheckFile = false;
                      _cubit!.file = io.File('');
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
                  _cubit!.isCheckFile = false;
                  _cubit!.file = io.File('');
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
