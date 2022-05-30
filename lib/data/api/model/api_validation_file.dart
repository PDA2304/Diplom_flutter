class ApiValidationFile {
  final List<dynamic>? fileName;
  final List<dynamic>? login;
  final List<dynamic>? file;

  ApiValidationFile.fromApi(Map<String, dynamic> map)
      : fileName = map['file_name'] ?? <dynamic>[],
        login = map['login'] ?? <dynamic>[],
        file = map['file'] ?? <dynamic>[];
}
