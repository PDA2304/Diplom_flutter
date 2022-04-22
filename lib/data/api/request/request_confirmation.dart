import 'package:flutter/cupertino.dart';

class RequestConfirmation {
  final String login;

  RequestConfirmation(@required this.login);

  Map<String, dynamic> toApi() {
    return {'login': login};
  }
}
