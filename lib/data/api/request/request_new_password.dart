class RequestNewPassword {
  final int id;
  final String newPassword;
  final String oldPassword;

  RequestNewPassword({
    required this.id,
    required this.newPassword,
    required this.oldPassword,
  });

  Map<String, dynamic> toApi() {
    return {
      'id': id,
      'new_password': newPassword,
      'old_password': oldPassword,
    };
  }
}
