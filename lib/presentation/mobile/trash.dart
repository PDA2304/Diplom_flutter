import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/type_text.dart';
import 'package:passmanager_diplom/domain/state/tash/trash_cubit.dart';

class Trash extends StatefulWidget {
  const Trash({Key? key, required this.userId}) : super(key: key);
  final int userId;
  @override
  State<Trash> createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  @override
  void initState() {
    context.read<TrashCubit>().init(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      centerTitle: true,
      title: BlocBuilder<TrashCubit, TrashState>(
        builder: (context, state) {
          return context.read<TrashCubit>().isSelect
              ? Text(
                  context.read<TrashCubit>().selectText(TypeText.countSelect),
                )
              : const Text("Корзина");
        },
      ),
      leading: BlocBuilder<TrashCubit, TrashState>(
        builder: (context, state) {
          return context.read<TrashCubit>().isSelect
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.read<TrashCubit>().closeSelect();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
        },
      ),
      actions: [
        BlocConsumer<TrashCubit, TrashState>(
          listener: (context, state) {},
          builder: (context, state) {
            return context.read<TrashCubit>().isSelect ||
                    context.read<TrashCubit>().trashList.isEmpty
                ? Container()
                : PopupMenuButton(
                    tooltip: "Действия",
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.select_all_sharp,
                                color: Colors.blue,
                              ),
                            ),
                            Text('Выбрать всё')
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.restore,
                                color: Colors.blue,
                              ),
                            ),
                            Text('Восстановить всё')
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            Text('Очистить корзину')
                          ],
                        ),
                      )
                    ],
                    onSelected: (item) {
                      switch (item) {
                        case 0:
                          {
                            return context.read<TrashCubit>().selectDataAll();
                          }
                        case 1:
                          {
                            return context
                                .read<TrashCubit>()
                                .restorationAll(userId: widget.userId);
                          }
                        case 2:
                          {
                            return context
                                .read<TrashCubit>()
                                .deleteAll(userId: widget.userId);
                          }
                      }
                    },
                    icon: const Icon(Icons.more_vert_outlined),
                  );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: BlocBuilder<TrashCubit, TrashState>(
        builder: (context, state) {
          if ((state) is TrashLoad) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return (state as TrashResponse).trashList.isEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.delete_outline_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text(
                            "Корзина пуста",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      context.read<TrashCubit>().onRefresh(widget.userId),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.trashList.length,
                              itemBuilder: (context, count) {
                                return Card(
                                  child: ListTile(
                                    onLongPress: () {
                                      context.read<TrashCubit>().selectData(
                                            index: count,
                                            check: true,
                                          );
                                    },
                                    onTap: () {},
                                    title: Text(state.trashList[count].name),
                                    subtitle: Row(
                                      children: [
                                        state.trashList[count].isCreator
                                            ? Container()
                                            : const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                child: Icon(
                                                  Icons.people_alt_outlined,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        Text(
                                          DateFormat('d MMMM y', 'ru').format(
                                              state.trashList[count].createAt),
                                        ),
                                      ],
                                    ),
                                    leading: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 6),
                                      child: Container(
                                        child: _iconTabletype(
                                            state.trashList[count].typeTable),
                                      ),
                                    ),
                                    trailing: AnimatedContainer(
                                      height:
                                          context.read<TrashCubit>().isSelect
                                              ? appBar.preferredSize.height
                                              : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.5),
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            value:
                                                state.trashList[count].isCheck,
                                            onChanged: (bool? value) {
                                              context
                                                  .read<TrashCubit>()
                                                  .selectData(
                                                    index: count,
                                                    check: value!,
                                                  );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          AnimatedContainer(
                            height: context.read<TrashCubit>().isSelect
                                ? appBar.preferredSize.height
                                : 0,
                            duration: const Duration(milliseconds: 300),
                            color: Colors.blue,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  _rowBottomSheet(
                                      Icons.select_all_outlined,
                                      context
                                          .read<TrashCubit>()
                                          .selectText(TypeText.actionSelect),
                                      () => context
                                          .read<TrashCubit>()
                                          .selectDataAll(),
                                      false),
                                  _rowBottomSheet(
                                      Icons.restore,
                                      "Восстановить",
                                      () => context
                                          .read<TrashCubit>()
                                          .restoration(userId: widget.userId),
                                      context.read<TrashCubit>().isPressed),
                                  _rowBottomSheet(
                                      Icons.delete,
                                      "Удалить",
                                      () => context.read<TrashCubit>().delete(),
                                      context.read<TrashCubit>().isPressed)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _rowBottomSheet(
      IconData icon, String text, Function onPressed, bool isPressed) {
    return Expanded(
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.transparent,
          ),
          onPressed: isPressed ? null : () => onPressed(),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconTabletype(TypeTable typeTable) {
    switch (typeTable) {
      case TypeTable.notes:
        return const Icon(Icons.note_sharp);
      case TypeTable.files:
        return const Icon(Icons.file_copy);
      case TypeTable.account:
        return const Icon(Icons.account_box);
      case TypeTable.data:
        return Container();
    }
  }
}
