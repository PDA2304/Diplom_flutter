import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:passmanager_diplom/internal/application.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';
import 'package:passmanager_diplom/internal/dependencies/router.dart';

void main() async {
  initializeDateFormatting('ru');
  WidgetsFlutterBinding.ensureInitialized();
  var user = await RepositoryModule.crudRepository().read();
  runApp(Application(router: AppRouter(userAuth: user), isAuth: user.id == 0));
}
