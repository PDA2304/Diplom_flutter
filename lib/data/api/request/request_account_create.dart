class RequestAccountCreate {
  final String? accountName;
  final String? login;
  final String? password;
  final String? description;
  final int? userId;

  RequestAccountCreate({
    required this.accountName,
    required this.login,
    required this.password,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toApi() {
    return {
      'user_id': userId,
      'account_name': accountName,
      'login': login,
      'password': password,
      'description': description
    };
  }
}
