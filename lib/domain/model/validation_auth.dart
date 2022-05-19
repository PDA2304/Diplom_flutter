class ValidationAuth {
  final String? userName;
  final String? login;
  final String? password;

  ValidationAuth({
    this.userName,
    this.login,
    this.password,
  });

  ValidationAuth.Empty()
      : userName = null,
        login = null,
        password = null;
}
