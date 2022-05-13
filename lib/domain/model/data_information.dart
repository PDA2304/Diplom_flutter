import 'package:passmanager_diplom/domain/model/information_text.dart';

class DataInformation {
  final int userId;
  final List<InformationText> informationText;

  DataInformation({
    required this.userId,
    required this.informationText,
  });

  DataInformation.dataEmpty()
      : userId = 0,
        informationText = <InformationText>[];
}
