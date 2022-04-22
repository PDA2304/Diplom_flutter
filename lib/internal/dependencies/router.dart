import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_in.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_up.dart';

class AppRouter {
  Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case singIn:
        {
          return MaterialPageRoute(builder: (_) => const SingIn());
        }
    }
    return null;
  }
}
