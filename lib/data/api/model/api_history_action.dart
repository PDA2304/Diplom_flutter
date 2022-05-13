class ApiHistoryAction {
  final int userId;
  final String userName;
  final String typeAction;
  final String actionDate;

  ApiHistoryAction.fromApi(Map<String, dynamic> json)
      : userId = json['user_id'],
        userName = json['user_login'],
        typeAction = json['type_action'],
        actionDate = json['action_date'];
}
