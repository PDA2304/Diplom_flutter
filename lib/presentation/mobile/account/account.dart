import 'package:flutter/gestures.dart';
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
import 'package:passmanager_diplom/presentation/widgets/floating_action_message.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аккаунты'),
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
      drawer: AppDrawer(user: widget.user),
      floatingActionButton: FloatingActionButtonCutom(userId: widget.user.id),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          if ((state) is DataLoad) {
            return const Center(child: CircularProgressIndicator());
          }

          return (state.accountList.isEmpty)
              ? RefreshIndicator(
                  onRefresh: () => context.read<DataCubit>().onRefresh(
                        typetable: TypeTable.data,
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
                                "Добавьте первую заметку",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(2.5)),
                              const Text(
                                "Ваши данные всегда под рукой. \nВыможете хранить свои заметки.",
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
                      typetable: TypeTable.account, userId: widget.user.id),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: ListView.builder(
                      itemCount: state.accountList.length,
                      itemBuilder: (context, count) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                UrlPage.accountShowUpdate,
                                arguments: state.accountList[count],
                              );
                            },
                            child: ListTile(
                              title: Text(state.accountList[count].accountName),
                              leading: state.accountList[count].isCreator
                                  ? null
                                  : const Icon(
                                      Icons.share,
                                    ),
                              subtitle: Text(DateFormat('d MMMM y', 'ru')
                                  .format(state.accountList[count].createAt)),
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
