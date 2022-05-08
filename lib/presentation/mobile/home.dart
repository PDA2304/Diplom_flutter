import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_search.dart';
import 'package:passmanager_diplom/presentation/widgets/drawer.dart';
import 'package:passmanager_diplom/presentation/widgets/floating_action_button_custuom.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<DataCubit>().initData(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Все записи'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearch(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: AppDrawer(
        user: widget.user,
      ),
      floatingActionButton: FloatingActionButtonCutom(userId: widget.user.id),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          return (state is DataLoad)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: state.dataList.length,
                  itemBuilder: (context, count) {
                    return Card(
                      child: ListTile(
                          onLongPress: () {},
                          onTap: () {
                            switch (state.dataList[count].typeTable) {
                              case TypeTable.notes:
                                Navigator.pushNamed(
                                  context,
                                  UrlPage.notesShowUpdate,
                                  arguments: state.notesList.firstWhere((element) =>
                                      element.id == state.dataList[count].id),
                                );
                                break;
                              case TypeTable.files:
                                // TODO: Handle this case.
                                break;
                              case TypeTable.account:
                                Navigator.pushNamed(
                                  context,
                                  UrlPage.accountShowUpdate,
                                  arguments: state.accountList.firstWhere(
                                      (element) =>
                                          element.id ==
                                          state.dataList[count].id),
                                );
                                break;
                            }
                          },
                          title: Text(state.dataList[count].name),
                          subtitle: Row(
                            children: [
                              state.dataList[count].isCreator
                                  ? Container()
                                  : const Icon(
                                      Icons.people_alt_outlined,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.5)),
                              Text(DateFormat('d MMMM y', 'ru')
                                  .format(state.dataList[count].createAt)),
                            ],
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 6),
                            child: Container(
                              child: iconTabletype(
                                  state.dataList[count].typeTable),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right)),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget iconTabletype(TypeTable typeTable) {
    switch (typeTable) {
      case TypeTable.notes:
        return Icon(Icons.note_sharp);
      case TypeTable.files:
        return Icon(Icons.file_copy);
      case TypeTable.account:
        return Icon(Icons.account_box);
    }
  }
}
