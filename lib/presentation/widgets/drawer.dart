import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/generate_color.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        return Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: MediaQuery.of(context).padding.top + 5,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: GenerateColor.generate(user.id),
                      radius: 25,
                      child: Center(
                        child: Text(
                          user.userName[0].toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userName,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, UrlPage.settings),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.blue,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              itemDrawer(
                title: 'Все записи',
                icon: Icons.all_inbox,
                onTap: () {
                  Navigator.pushReplacementNamed(context, UrlPage.home,
                      arguments: user);
                },
              ),
              itemDrawer(
                title: 'Аккаунты',
                icon: Icons.account_box,
                onTap: () {
                  Navigator.pushReplacementNamed(context, UrlPage.account,
                      arguments: user);
                },
              ),
              itemDrawer(
                title: 'Заметки',
                icon: Icons.note_sharp,
                onTap: () {
                  Navigator.pushReplacementNamed(context, UrlPage.notes,
                      arguments: user);
                },
              ),
              itemDrawer(
                title: 'Файлы',
                icon: Icons.file_copy,
                onTap: () {
                  Navigator.pushReplacementNamed(context, UrlPage.files,
                      arguments: user);
                },
              ),
              Expanded(flex: 1, child: Container()),
              itemDrawer(
                title: 'Выход',
                icon: Icons.exit_to_app_outlined,
                onTap: () {
                  context.read<DataCubit>().onExit();
                  Navigator.pushNamedAndRemoveUntil(
                      context, UrlPage.singIn, (route) => false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget itemDrawer({
    required String title,
    required IconData icon,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () => onTap(),
    );
  }
}
