class ValidationFile {
  final String? fileName;
  final String? login;
  final String? file;

  ValidationFile({
    required this.fileName,
    required this.login,
    required this.file,
  });

  ValidationFile.empty()
      : fileName = null,
        file = null,
        login = null;
}
