class RequestSingIn {
  final String login;
  final String password;

  RequestSingIn({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toApi() {
    return {
      'login': login,
      'password': password,
    };
  }
}
