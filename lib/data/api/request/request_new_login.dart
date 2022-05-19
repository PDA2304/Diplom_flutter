class RequestNewLogin {
  final int id;
  final String login;

  RequestNewLogin({
    required this.id,
    required this.login,
  });

  Map<String, dynamic> toApi() {
    return {
      'id': id,
      'login': login,
    };
  }
}
