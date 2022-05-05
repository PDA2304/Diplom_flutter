import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, count) {
                return Card(
                  child: ListTile(
                      onLongPress: () {},
                      onTap: () {},
                      title: Text('Название'),
                      subtitle: Text('23 апреля 2022'),
                      trailing: const Icon(Icons.keyboard_arrow_right)),
                );
              });
        },
      ),
    );
  }
}
