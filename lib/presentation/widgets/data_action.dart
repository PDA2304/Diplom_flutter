import 'package:flutter/material.dart';

class DataAction extends StatelessWidget {
  const DataAction({Key? key, required this.onSelected}) : super(key: key);

  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                    ),
                    Text('Описание')
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
                        Icons.group_add_sharp,
                        color: Colors.blue,
                      ),
                    ),
                    Text('Поделиться данными')
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
                    Text('Удалить')
                  ],
                ),
              )
            ],
        onSelected: onSelected,
        icon: const Icon(Icons.more_vert_outlined));
  }
}
