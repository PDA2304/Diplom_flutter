import 'package:flutter/material.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_search.dart';
import 'package:passmanager_diplom/presentation/widgets/drawer.dart';
import 'package:passmanager_diplom/presentation/widgets/floating_action_button_custuom.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Заметки'),
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
      floatingActionButton: const FloatingActionButtonCutom(),
      body: Container(),
    );
  }
}
