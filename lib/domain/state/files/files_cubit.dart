import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:passmanager_diplom/constant/type_extensions.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/files.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/model/validation_file.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:path_provider/path_provider.dart';

part 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit(this._dataCubit) : super(FilesInitial());
  final DataCubit _dataCubit;

  io.File file = io.File('');
  String fileExtensions = '';
  String pathSaveFile = '';

  String dowloadIndicator = '';
  bool isCheckFile = false;
  bool isDowload = false;
  int size = 0;
  double process = 0;
  Dio dio = Dio();

  TextEditingController filesNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void init(File data) async {
    filesNameController.text = data.fileName;
    descriptionController.text = data.description;
    var documentDirectory = await getApplicationDocumentsDirectory();
    fileExtensions = data.path.substring(
        data.path.indexOf('.', data.path.indexOf('storage')) + 1,
        data.path.length);
    pathSaveFile =
        "${documentDirectory.path}/PassManager/${data.fileName}.$fileExtensions";
    if (!await io.File(pathSaveFile).exists()) {
      isCheckFile = true;
      await dio.download(
        data.path,
        pathSaveFile,
        onReceiveProgress: ((count, total) {
          dowloadIndicator = ((count / total) * 100).toStringAsFixed(2) + '%';
          process = (count / total).toDouble();
          emit(FilesInitial());
        }),
      );
    }
    isDowload = true;
    file = io.File(pathSaveFile);
    emit(FilesInitial());

    // 'https://million-wallpapers.ru/wallpapers/7/0/535923367045443/derevyannyj-dom-ruchej-voda.jpg'
  }

  void update(File data) async {
    if (file.path == '') {
      emit(
        FilesErorr(
          File(
            id: 0,
            fileName: '',
            description: '',
            path: '',
            createdAt: DateTime.now(),
            isCreator: true,
            size: 0,
            validationFile: ValidationFile(
              file: 'Файл не выбран',
              fileName: null,
              login: null,
            ),
          ),
        ),
      );
      return;
    }
    var result = await _dataCubit.crudFilesRepository.update(
      id: data.id,
      fileName: filesNameController.text,
      description: descriptionController.text,
      file: file,
      size: data.size,
    );
    if (result.id == 0) {
      emit(FilesErorr(result));
    } else {
      if (pathSaveFile != file.path) {
        io.File(pathSaveFile).deleteSync();
      }
      _dataCubit.updateFiles(result);
      emit(FilesResponse());
    }
  }

  void cancel(File data) {
    filesNameController.text = data.fileName;
    descriptionController.text = data.description;
    file = io.File(pathSaveFile);
    isCheckFile = true;
    emit(FilesInitial());
  }

  /// Создание новой записи
  void filesCreate(String fileName, String description, User user) async {
    if (file.path == '') {
      emit(
        FilesErorr(
          File(
            id: 0,
            fileName: '',
            description: '',
            path: '',
            createdAt: DateTime.now(),
            isCreator: true,
            size: 0,
            validationFile: ValidationFile(
              file: 'Файл не выбран',
              fileName: null,
              login: null,
            ),
          ),
        ),
      );
      return;
    }
    var files = await _dataCubit.crudFilesRepository.create(
      fileName: fileName,
      description: description,
      login: user.email,
      file: file,
      size: size,
      userId: user.id,
    );

    if (files.id == 0) {
      emit(FilesErorr(files));
    } else {
      _dataCubit.addFiles(files);
      emit(FilesResponse());
    }
  }

  /// Открыйтие файла
  void fileOpen() {
    OpenFile.open(file.path);
  }

  /// Выбор файла
  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      dialogTitle: 'Выбор файла',
      allowedExtensions: TypeExtension.extensions,
    );
    if (result != null) {
      size = result.files.first.size;
      file = io.File(result.files.single.path!);
      fileExtensions = result.files.first.extension!;
      isCheckFile = true;
      emit(FilesInitial());
    } else {}
  }

  void dispose() async {
    // if (await io.File(pathSaveFile).exists()) {
    //   await io.File(pathSaveFile).delete();
    // }
  }

  /// Логическое удаление
  void filesDelete({required int id}) {
    _dataCubit.onDelete(TypeTable.files, id);
  }
}
