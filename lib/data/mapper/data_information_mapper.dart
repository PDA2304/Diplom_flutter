import 'package:passmanager_diplom/data/api/model/api_data_information.dart';
import 'package:passmanager_diplom/domain/model/data_information.dart';
import 'package:passmanager_diplom/domain/model/information_text.dart';

class DataInformationMapper {
  static DataInformation fromApi(ApiDataInformation model) {
    return DataInformation(
      userId: model.userId,
      informationText: model.informationText
          .map((e) => InformationText(
                title: e.title,
                content: e.content,
              ))
          .toList(),
    );
  }
}
