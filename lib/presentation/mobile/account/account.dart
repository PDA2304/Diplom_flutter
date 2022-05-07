import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_search.dart';
import 'package:passmanager_diplom/presentation/widgets/drawer.dart';
import 'package:passmanager_diplom/presentation/widgets/floating_action_button_custuom.dart';

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
          return (state is DataLoad)
              ? const Center(child: CircularProgressIndicator())
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
