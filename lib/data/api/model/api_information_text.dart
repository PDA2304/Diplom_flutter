class ApiInformationText {
  final String title;
  final String content;

  ApiInformationText.fromApi(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'];
}
