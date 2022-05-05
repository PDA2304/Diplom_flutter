import 'package:flutter/material.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_search.dart';
import 'package:passmanager_diplom/presentation/widgets/drawer.dart';
import 'package:passmanager_diplom/presentation/widgets/floating_action_button_custuom.dart';

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
      floatingActionButton: FloatingActionButtonCutom(userId: widget.user.id),
      drawer: AppDrawer(user: widget.user),
      body: Container(),
    );
  }
}
