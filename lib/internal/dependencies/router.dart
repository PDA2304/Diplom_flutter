import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/presentation/mobile/confirmation.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_in.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_up.dart';

class AppRouter {
  Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case UrlPage.singIn:
        {
          return MaterialPageRoute(builder: (_) => const SingIn());
        }
      case UrlPage.singUp:
        {
          return MaterialPageRoute(builder: (_) => const SingUp());
        }
      case UrlPage.confirmation:
        {
          return MaterialPageRoute(builder: (_) => const Confirmation());
        }
    }
    return null;
  }
}
