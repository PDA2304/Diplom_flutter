import 'package:passmanager_diplom/data/api/model/api_validation_file.dart';

class ApiFile {
  final int? id;
  final String? fileName;
  final String? path;
  final String? description;
  final int? size;
  final String? createdAt;
  final bool? isCreator;
  final ApiValidationFile? apiValidationFile;

  ApiFile.fromApi(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        fileName = json['files_name'] ?? '',
        path = json['path'] ?? '',
        description = json['description'] ?? '',
        size = json['size'] ?? 0,
        createdAt = json['created_at'] ?? DateTime.now().toIso8601String(),
        isCreator = json['creator'] ?? true,
        apiValidationFile = json['error'] != null
            ? ApiValidationFile.fromApi(json['error'])
            : null;
}
