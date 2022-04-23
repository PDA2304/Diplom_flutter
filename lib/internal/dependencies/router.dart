import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart'
    as ModelConfirmation;
import 'package:passmanager_diplom/domain/state/cubit/sing_up_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';
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
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (_) =>
                        SingUpCubit(RepositoryModule.authRepository()),
                    child: const SingUp(),
                  ));
        }
      case UrlPage.confirmation:
        {
          var confirmation =
              settings.arguments as ModelConfirmation.Confirmation;
          return MaterialPageRoute(
              builder: (_) => Confirmation(confirmation: confirmation));
        }
    }
    return null;
  }
}
