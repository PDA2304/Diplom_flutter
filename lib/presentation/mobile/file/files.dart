import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:passmanager_diplom/presentation/widgets/action_long_press.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_search.dart';
import 'package:passmanager_diplom/presentation/widgets/drawer.dart';
import 'package:passmanager_diplom/presentation/widgets/floating_action_button_custuom.dart';
import 'package:passmanager_diplom/presentation/widgets/floating_action_message.dart';

class Files extends StatefulWidget {
  const Files({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Файлы'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButtonCutom(user: widget.user),
      drawer: AppDrawer(user: widget.user),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          if ((state) is DataLoad) {
            return const Center(child: CircularProgressIndicator());
          }
          return (state.filesList.isEmpty)
              ? RefreshIndicator(
                  onRefresh: () => context.read<DataCubit>().onRefresh(
                        typetable: TypeTable.files,
                        userId: widget.user.id,
                      ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: <Widget>[
                              Expanded(child: Container()),
                              const Text(
                                "Добавьте первый файл",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(2.5)),
                              const Text(
                                "Ваши данные всегда под рукой. \nВыможете хранить свои файлы.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(child: Container()),
                              Container(
                                padding: const EdgeInsets.only(
                                  right: 40,
                                  bottom: 90,
                                ),
                                alignment: AlignmentGeometry.lerp(
                                  Alignment.centerRight,
                                  Alignment.centerRight,
                                  0,
                                ),
                                child: const FloatingActionMessage(
                                    color: Colors.blue),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => context.read<DataCubit>().onRefresh(
                      typetable: TypeTable.files, userId: widget.user.id),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: ListView.builder(
                      itemCount: state.filesList.length,
                      itemBuilder: (context, count) {
                        return Card(
                          child: InkWell(
                            onLongPress: () {
                              // ! Нужно сделать
                              ActionLongPress(
                                      id: state.filesList[count].id,
                                      typeTable: TypeTable.files,
                                      cubit: context.read<DataCubit>())
                                  .show(context);
                            },
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                UrlPage.filesShowUpdate,
                                arguments: state.filesList[count],
                              );
                            },
                            child: ListTile(
                              title: Text(state.filesList[count].fileName),
                              leading: state.filesList[count].isCreator
                                  ? null
                                  : const Icon(
                                      Icons.share,
                                    ),
                              subtitle: Text(DateFormat('d MMMM y', 'ru')
                                  .format(state.filesList[count].createdAt)),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
