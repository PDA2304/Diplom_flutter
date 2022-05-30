import 'package:passmanager_diplom/data/api/model/api_file.dart';
import 'package:passmanager_diplom/data/api/model/api_validation_file.dart';
import 'package:passmanager_diplom/data/mapper/validation_file_mapper.dart';
import 'package:passmanager_diplom/domain/model/files.dart';
import 'package:passmanager_diplom/domain/model/validation_file.dart';

class FileMapper {
  static File fromApi(ApiFile model) {
    return File(
      id: model.id!,
      fileName: model.fileName!,
      description: model.description!,
      path:  model.path!,
      createdAt: DateTime.parse(model.createdAt!).toLocal(),
      isCreator: model.isCreator!,
      size: model.size!,
      validationFile: model.apiValidationFile == null
          ? null
          : ValidationFileMapper.fromApi(model.apiValidationFile),
    );
  }
}
