import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/state/search_data/search_data_cubit.dart';

class CustomSearch extends SearchDelegate {
  final TypeTable typeTable;
  final SearchDataCubit _cubit;

  CustomSearch(this.typeTable, this._cubit);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    _cubit.search(typeTable, query);
    return BlocBuilder<SearchDataCubit, SearchDataState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is SearchData) {
          return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      switch (state.list[index].typeTable) {
                        case TypeTable.notes:
                          Navigator.pushNamed(
                            context,
                            UrlPage.notesShowUpdate,
                            arguments: _cubit.dataCubit.state.notesList
                                .firstWhere((element) =>
                                    element.id == state.list[index].id),
                          );
                          break;
                        case TypeTable.files:
                          {
                            Navigator.pushNamed(
                              context,
                              UrlPage.filesShowUpdate,
                              arguments: _cubit.dataCubit.state.filesList
                                  .firstWhere((element) =>
                                      element.id == state.list[index].id),
                            );
                            break;
                          }
                        case TypeTable.account:
                          Navigator.pushNamed(
                            context,
                            UrlPage.accountShowUpdate,
                            arguments: _cubit.dataCubit.state.accountList
                                .firstWhere((element) =>
                                    element.id == state.list[index].id),
                          );
                          break;
                        case TypeTable.data:
                          break;
                      }
                    },
                    title: Text(state.list[index].name),
                    subtitle: Row(
                      children: [
                        state.list[index].isCreator
                            ? Container()
                            : const Icon(
                                Icons.people_alt_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.5)),
                        Text(DateFormat('d MMMM y', 'ru')
                            .format(state.list[index].createAt)),
                      ],
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 6),
                      child: Container(
                        child: iconTabletype(state.list[index].typeTable),
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                );
              });
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget iconTabletype(TypeTable typeTable) {
    switch (typeTable) {
      case TypeTable.notes:
        return Icon(Icons.note_sharp);
      case TypeTable.files:
        return Icon(Icons.file_copy);
      case TypeTable.account:
        return Icon(Icons.account_box);
      case TypeTable.data:
        return Container();
    }
  }
}
