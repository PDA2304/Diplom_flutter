class RequestNewUserName {
  final int id;
  final String userName;

  RequestNewUserName({
    required this.id,
    required this.userName,
  });

  Map<String, dynamic> toApi() {
    return {
      'id': id,
      'user_name': userName,
    };
  }
}
