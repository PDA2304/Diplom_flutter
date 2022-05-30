import 'dart:io';

class RequsetFileUpdate {
  final int id;
  final String fileName;
  final String description;
  final int size;
  final File file;

  RequsetFileUpdate({
    required this.id,
    required this.fileName,
    required this.description,
    required this.size,
    required this.file,
  });
}
