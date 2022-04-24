import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/internal/dependencies/router.dart';

class Application extends StatelessWidget {
  final User user;

  const Application({
    Key? key,
    required this.router,
    required this.user,
  }) : super(key: key);
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PassManager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: router.generateRouter,
      initialRoute: user.id == 0 ? UrlPage.singIn : UrlPage.home,
    );
  }
}
