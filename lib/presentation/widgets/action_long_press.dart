import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';

class ActionLongPress {
  final int id;
  final TypeTable typeTable;
  final DataCubit cubit;

  ActionLongPress({
    required this.id,
    required this.typeTable,
    required this.cubit,
  });

  show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) => Wrap(
        children: [
          ListTile(
            title: const Text('История действий'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Информация'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Поделиться данными'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Удалить'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return _allerDialogDelete(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _allerDialogDelete(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Удаление"),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            cubit.onDelete(typeTable, id);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Да"),
          textStyle: const TextStyle(color: Colors.red),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Нет"),
          textStyle: const TextStyle(color: Colors.green),
        ),
      ],
      content: const Text(
          "Вы действительно хотите \n переместить данные в корзину?"),
    );
  }
}
