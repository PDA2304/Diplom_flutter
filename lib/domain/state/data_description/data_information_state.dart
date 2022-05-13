part of 'data_information_cubit.dart';

@immutable
abstract class DataDescriptionState {
  final List<HistoryAction> historyActionList;
  final List<UserShare> userShareList;
  final DataInformation dataInformation;

  bool isSuccesHistoryAction = false;
  bool isSuccesUserShare = false;
  bool isSuccesDataInformation = false;

  DataDescriptionState(
      this.historyActionList, this.userShareList, this.dataInformation);
}

class DataDescriptionInitial extends DataDescriptionState {
  DataDescriptionInitial(
    List<HistoryAction> historyActionList,
    List<UserShare> userShareList,
    DataInformation dataInformation,
  ) : super(historyActionList, userShareList, dataInformation);
}

class DataDescriptionLoad extends DataDescriptionState {
  DataDescriptionLoad(
    List<HistoryAction> historyActionList,
    List<UserShare> userShareList,
    DataInformation dataInformation,
  ) : super(historyActionList, userShareList, dataInformation);
}

class DataDescriptionResponse extends DataDescriptionState {
  final List<HistoryAction> historyActionList;
  final List<UserShare> userShareList;
  final DataInformation dataInformation;

  DataDescriptionResponse(
      this.historyActionList, this.userShareList, this.dataInformation)
      : super(historyActionList, userShareList, dataInformation);
}
