class ValidationNewUserName {
  final String? userName;

  ValidationNewUserName({required this.userName});

  ValidationNewUserName.isEmpty() : userName = null;
}
