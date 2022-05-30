import 'dart:io';
class RequestFileCreate {
  final int userId;
  final String fileName;
  final String description;
  final String login;
  final int size;
  final File file;

  RequestFileCreate({
    required this.userId,
    required this.fileName,
    required this.description,
    required this.login,
    required this.size,
    required this.file,
  });
}
