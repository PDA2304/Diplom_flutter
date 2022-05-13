import 'package:passmanager_diplom/data/api/model/api_information_text.dart';

class ApiDataInformation {
  final int userId;
  final List<ApiInformationText> informationText;

  ApiDataInformation.fromApi(Map<String, dynamic> json)
      : userId = json['user_id'] ?? 0,
        informationText = json['information_text'] == null
            ? <ApiInformationText>[]
            : (json['information_text'] as List)
                .map((e) => ApiInformationText.fromApi(e))
                .toList();
}
