import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/constant/type_text.dart';
import 'package:passmanager_diplom/domain/model/trash.dart';
import 'package:passmanager_diplom/domain/model/trash_data.dart';
import 'package:passmanager_diplom/domain/repository/trash_repository.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';

part 'trash_state.dart';

class TrashCubit extends Cubit<TrashState> {
  TrashCubit(this._trashRepository, this._dataCubit) : super(TrashInitial());

  final TrashRepository _trashRepository;
  final DataCubit _dataCubit;

  List<TrashData> trashList = <TrashData>[];
  List<Trash> trashSelectList = <Trash>[];
  bool isSelect = false;
  bool isPressed = false;

  void init(int userId) async {
    emit(TrashLoad());
    trashList.addAll(await _trashRepository.index(userId: userId));
    emit(TrashResponse(trashList));
  }

  Future onRefresh(int userId) async {
    trashList.clear();
    init(userId);
  }

  /// Функция выбора всех элементов
  void selectDataAll() {
    isSelect = true;
    if (trashList.where((element) => element.isCheck == false).isEmpty) {
      trashSelectList = <Trash>[];
      selectCheckChanged(trashList, true);
    } else {
      trashList.where((element) => element.isCheck == false).forEach((element) {
        trashSelectList.add(Trash(element.id, element.typeTable.index));
        element.isCheck = true;
      });
    }
    selectText(TypeText.countSelect);
    emit(TrashResponse(trashList));
  }

  ///Функция смены состояни элемента на противоположный
  void selectData({required int index, required bool check}) {
    isSelect = true;
    var trash = trashList.elementAt(index);
    trash.isCheck = check;
    check
        ? trashSelectList.add(Trash(trash.id, trash.typeTable.index))
        : trashSelectList.removeWhere((element) =>
            (element.id == trash.id) &&
            (element.typeTable == trash.typeTable.index));
    isPressed = trashSelectList.isEmpty ? true : false;
    emit(TrashResponse(trashList));
  }

  /// Отмена выделения объекта
  void closeSelect() {
    isSelect = false;
    selectCheckChanged(trashList, true);
    emit(TrashResponse(trashList));
  }

  /// Функция смены состояния выбранных элементов
  void selectCheckChanged(List<TrashData> list, bool check) {
    trashList.where((element) => element.isCheck == check).forEach((element) {
      element.isCheck = !check;
    });
  }

  /// Функция вывода текста в зависимовости от преданной в нее типа
  String selectText(TypeText typeText) {
    int count = trashList.where((element) => element.isCheck == true).length;
    String selectText = '';
    switch (typeText) {
      case TypeText.actionSelect:
        {
          if (count == trashList.length) {
            selectText = "Снять выделения";
          } else {
            selectText = "Выбрать всё";
          }
          break;
        }
      case TypeText.countSelect:
        {
          if (count == 0) {
            isPressed = true;
            selectText = "Выбрать элемент";
          } else {
            isPressed = false;
            selectText = "Выбрано: $count";
          }
          break;
        }
    }
    return selectText;
  }

  void restorationAll({required int userId}) async {
    if (await _trashRepository.restorationAll(userId: userId)) {
      _dataCubit.restoration(data: trashList, userId: userId);
      trashList.clear();
      trashSelectList.clear();
      emit(TrashResponse(trashList));
    } else {
      print('');
    }
  }

  void restoration({required int userId}) async {
    if (await _trashRepository.restoration(trash: trashSelectList)) {
      _dataCubit.restoration(
          data: trashList.where((element) => element.isCheck == true).toList(),
          userId: userId);
      trashList.removeWhere((element) => element.isCheck == true);
      trashSelectList.clear();
      isSelect = false;
      isPressed = false;
      emit(TrashResponse(trashList));
    } else {
      print('');
    }
  }

  void deleteAll({required int userId}) async {
    if (await _trashRepository.deleteAll(userId: userId)) {
      trashList.clear();
      trashSelectList.clear();
      emit(TrashResponse(trashList));
    } else {
      print('');
    }
  }

  void delete() async {
    if (await _trashRepository.delete(trash: trashSelectList)) {
      trashList.removeWhere((element) => element.isCheck == true);
      trashSelectList.clear();
      isSelect = false;
      isPressed = false;
      emit(TrashResponse(trashList));
    } else {
      print('');
    }
  }
}
