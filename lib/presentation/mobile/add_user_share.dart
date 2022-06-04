import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/add_user_share/user_search_bloc.dart';
import 'package:passmanager_diplom/internal/dependencies/generate_color.dart';

class AddUserShare extends StatefulWidget {
  const AddUserShare(
      {Key? key,
      required this.typeTable,
      required this.dataId,
      required this.userId})
      : super(key: key);
  final TypeTable typeTable;
  final int dataId;
  final int userId;

  @override
  State<AddUserShare> createState() => _AddUserShareState();
}

class _AddUserShareState extends State<AddUserShare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Поделиться данными'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: this.context,
                delegate: CustomSearch(
                    list: <User>[],
                    typeTable: widget.typeTable,
                    dataId: widget.dataId,
                    bloc: context.read<UserSearchBloc>()),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<UserSearchBloc>().add(
                AddShareUserEvent(
                  typeTable: widget.typeTable,
                  dataId: widget.dataId,
                  userSenderId: widget.userId,
                ),
              );
        },
        label: const Text('Поделиться'),
      ),
      body: Column(children: [
        Expanded(
          child: BlocConsumer<UserSearchBloc, UserSearchState>(
            listener: (context, state) {
              if (state is ShareError) {
                print('1');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
              if (state is ShareSucces) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return ListView.builder(
                  itemCount: state.listCheck.length,
                  itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: GenerateColor.generate(
                                  state.listCheck[index].id),
                              radius: 25,
                              child: Text(
                                state.listCheck[index].userName[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                context.read<UserSearchBloc>().add(
                                    RemoveCheckUserEvent(
                                        state.listCheck[index]));
                              },
                              child: const Icon(Icons.clear),
                            ),
                            title: Container(
                                alignment: Alignment.centerLeft,
                                width: 200,
                                height: 35,
                                child: FittedBox(
                                    child: Text(state.listCheck[index].email))),
                          ),
                        ),
                      ));
            },
          ),
        ),
      ]),
    );
  }
}

class CustomSearch extends SearchDelegate<List> {
  final List<User> list;
  final TypeTable typeTable;
  final int dataId;
  final UserSearchBloc bloc;

  CustomSearch({
    required this.list,
    required this.typeTable,
    required this.dataId,
    required this.bloc,
  });

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
          close(context, <dynamic>[]);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.add(RequestEvent(query, typeTable, dataId));
    return BlocBuilder<UserSearchBloc, UserSearchState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is UserSearchLoad) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserResponse) {
          return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          GenerateColor.generate(state.list[index].user.id),
                      radius: 25,
                      child: Text(
                        state.list[index].user.userName[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      child: state.list[index].isChek
                          ? ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(color: Colors.blue),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                bloc.add(
                                  CheckUserEvent(
                                      state.list[index].user.id, false),
                                );
                              },
                              child: const Icon(
                                Icons.check,
                                color: Colors.blue,
                                size: 18,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                bloc.add(
                                  CheckUserEvent(
                                      state.list[index].user.id, true),
                                );
                              },
                              child: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                    ),
                    title: Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      height: 35,
                      child: FittedBox(
                        child: Text(state.list[index].user.email),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Поиск пользователя'),
    );
  }
}
