import 'package:passmanager_diplom/data/api/model/api_validation_file.dart';
import 'package:passmanager_diplom/domain/model/validation_file.dart';

class ValidationFileMapper {
  static ValidationFile fromApi(ApiValidationFile? model) {
    return model == null
        ? ValidationFile.empty()
        : ValidationFile(
            fileName: model.fileName!.isEmpty ? null : model.fileName!.first,
            login: model.login!.isEmpty ? null : model.login!.first,
            file: model.file!.isEmpty ? null : model.file!.first,
          );
  }
}
