import 'package:flutter/material.dart';
import 'package:passmanager_diplom/internal/dependencies/router.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_in.dart';

class Application extends StatelessWidget {
  const Application({
    Key? key,
    required this.router,
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
      home: const SingIn(),
    );
  }
}
