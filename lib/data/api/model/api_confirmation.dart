class ApiConfirmation {
  final String number;

  ApiConfirmation.fromApi(Map<String, dynamic> json) : number = json['number'];
}
