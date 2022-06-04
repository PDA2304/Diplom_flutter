import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/model/user_share.dart';
import 'package:passmanager_diplom/domain/state/remove_user_share/remove_user_share_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/generate_color.dart';

class RemoveUserShare extends StatefulWidget {
  const RemoveUserShare({
    Key? key,
    required this.dataId,
    required this.userSenderId,
    required this.typeTable,
    required this.list,
  }) : super(key: key);
  final int dataId;
  final int userSenderId;
  final TypeTable typeTable;
  final List<UserShare> list;

  @override
  State<RemoveUserShare> createState() => _RemoveUserShareState();
}

class _RemoveUserShareState extends State<RemoveUserShare> {
  @override
  void initState() {
    context.read<RemoveUserShareCubit>().init(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Пользователи'),
      ),
      body: BlocBuilder<RemoveUserShareCubit, RemoveUserShareState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        GenerateColor.generate(widget.list[index].userId),
                    radius: 25,
                    child: Text(
                      widget.list[index].userName[0],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(widget.list[index].userLogin),
                  trailing: false
                      ? Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            context.read<RemoveUserShareCubit>().remove(
                                  widget.dataId,
                                  widget.typeTable,
                                  widget.userSenderId,
                                  state.list[index].userId,
                                );
                          },
                          child: Text('Удалить'),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
