class RequestAccountUpdate {
  final int? id;
  final String? accountName;
  final String? login;
  final String? password;
  final String? description;

  RequestAccountUpdate({
    required this.id,
    required this.accountName,
    required this.login,
    required this.password,
    required this.description,
  });

  Map<String, dynamic> toApi() {
    return {
      'id': id,
      'account_name': accountName,
      'login': login,
      'password': password,
      'description': description
    };
  }
}
