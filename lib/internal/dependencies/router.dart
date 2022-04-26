import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart'
    as ModelConfirmation;
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/sing_in/sing_in_cubit.dart';
import 'package:passmanager_diplom/domain/state/sing_up/sing_up_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';
import 'package:passmanager_diplom/presentation/mobile/confirmation.dart';
import 'package:passmanager_diplom/presentation/mobile/home.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_in.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_up.dart';

class AppRouter {
  final User userAuth;

  AppRouter({required this.userAuth});

  Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case UrlPage.singIn:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (_) => SingInCubit(
                      RepositoryModule.authRepository(),
                      RepositoryModule.crudRepository(),
                    ),
                    child: const SingIn(),
                  ));
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
      case UrlPage.home:
        {
          var user = settings.arguments == null
              ? userAuth
              : settings.arguments as User;
          return MaterialPageRoute(
            
            builder: (_) => Home(
              user: user,
            ),
          );
        }
    }
    return null;
  }
}
