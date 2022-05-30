// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:passmanager_diplom/domain/model/validation_file.dart';

class File {
  final int id;
  final String fileName;
  final String description;
  final String path;
  final DateTime createdAt;
  final bool isCreator;
  final int size;
  final ValidationFile? validationFile;

  File({
    required this.id,
    required this.fileName,
    required this.description,
    required this.path,
    required this.createdAt,
    required this.isCreator,
    required this.size,
    required this.validationFile,
  });

  File.empty()
      : id = 0,
        fileName = '',
        description = '',
        path = '',
        createdAt = DateTime.now(),
        isCreator = true,
        size = 0,
        validationFile = null;
}
