import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/data.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';

part 'search_data_state.dart';

class SearchDataCubit extends Cubit<SearchDataState> {
  SearchDataCubit(this.dataCubit) : super(SearchDataInitial());

  final DataCubit dataCubit;

  void search(TypeTable typeTable, String query) {
    emit(SearchDataInitial());
    var result = dataCubit.state.dataList.toList();
    var t = result
        .where(
          (element) => typeTable == TypeTable.data
              ? element.name.contains(query)
              : (element.name.contains(query) &&
                  element.typeTable == typeTable),
        )
        .toList();

    emit(SearchData(t));
  }
}
