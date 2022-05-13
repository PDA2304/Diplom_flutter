class ApiUserShare {
  final int userId;
  final String userLogin;
  final String userName;
  final String createdShare;

  ApiUserShare.fromApi(Map<String, dynamic> json)
      : userId = json['user_id'],
        userLogin = json['user_login'],
        userName = json['user_name'],
        createdShare = json['created_share'];
}
