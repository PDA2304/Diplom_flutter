import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
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
            title: const Text('Описание'),
            onTap: () {
              _onNavigationDataDescription(context);
            },
          ),
          ListTile(
            title: const Text('Поделиться данными'),
            onTap: () {
              _onNavigationAddShareUser(context);
            },
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

  _onNavigationDataDescription(BuildContext context) {
    switch (typeTable) {
      case TypeTable.notes:
        {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            UrlPage.dataDescription,
            arguments: [
              id,
              TypeTable.notes,
            ],
          );
          break;
        }
      case TypeTable.files:
        {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            UrlPage.dataDescription,
            arguments: [
              id,
              TypeTable.files,
            ],
          );
          break;
        }
      case TypeTable.account:
        {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            UrlPage.dataDescription,
            arguments: [
              id,
              TypeTable.account,
            ],
          );
          break;
        }
      case TypeTable.data:
        break;
    }
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

  _onNavigationAddShareUser(BuildContext context) {
    switch (typeTable) {
      case TypeTable.notes:
        {
          Navigator.pushNamed(
            context,
            UrlPage.addUserShare,
            arguments: [
              TypeTable.notes,
              id,
            ],
          );
          break;
        }
      case TypeTable.files:
        {
          Navigator.pushNamed(
            context,
            UrlPage.addUserShare,
            arguments: [
              TypeTable.files,
              id,
            ],
          );
          break;
        }
      case TypeTable.account:
        {
          Navigator.pushNamed(
            context,
            UrlPage.addUserShare,
            arguments: [
              TypeTable.account,
              id,
            ],
          );
          break;
        }
      case TypeTable.data:
        break;
    }
  }
}
