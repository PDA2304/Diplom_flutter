import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/account.dart' as ModelAccount;
import 'package:passmanager_diplom/domain/model/confirmation.dart'
    as ModelConfirmation;
import 'package:passmanager_diplom/domain/model/notes.dart' as ModelNotes;
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/account/account_cubit.dart';
import 'package:passmanager_diplom/domain/state/data/data_cubit.dart';
import 'package:passmanager_diplom/domain/state/notes/notes_cubit.dart';
import 'package:passmanager_diplom/domain/state/sing_in/sing_in_cubit.dart';
import 'package:passmanager_diplom/domain/state/sing_up/sing_up_cubit.dart';
import 'package:passmanager_diplom/domain/state/tash/trash_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';
import 'package:passmanager_diplom/presentation/mobile/account/account_add.dart';
import 'package:passmanager_diplom/presentation/mobile/account/account_show_update.dart';
import 'package:passmanager_diplom/presentation/mobile/account/account.dart';
import 'package:passmanager_diplom/presentation/mobile/confirmation.dart';
import 'package:passmanager_diplom/presentation/mobile/files.dart';
import 'package:passmanager_diplom/presentation/mobile/files_add.dart';
import 'package:passmanager_diplom/presentation/mobile/home.dart';
import 'package:passmanager_diplom/presentation/mobile/notes/notes.dart';
import 'package:passmanager_diplom/presentation/mobile/notes/notes_add.dart';
import 'package:passmanager_diplom/presentation/mobile/notes/notes_show_update.dart';
import 'package:passmanager_diplom/presentation/mobile/settings.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_in.dart';
import 'package:passmanager_diplom/presentation/mobile/sing_up.dart';
import 'package:passmanager_diplom/presentation/mobile/trash.dart';

class AppRouter {
  final User userAuth;

  AppRouter({required this.userAuth});

  final DataCubit _dataCubit = DataCubit(
    dataRepository: RepositoryModule.dataRepository(),
    crudNotesRepository: RepositoryModule.crudNotesRepository(),
    crudAccountRepository: RepositoryModule.crudAccountRepository(),
  );

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
            builder: (_) => BlocProvider.value(
              value: _dataCubit,
              child: Home(
                user: user,
              ),
            ),
          );
        }
      case UrlPage.account:
        {
          var user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _dataCubit,
              child: Accounts(
                user: user,
              ),
            ),
          );
        }
      case UrlPage.notes:
        {
          var user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _dataCubit,
              child: Notes(
                user: user,
              ),
            ),
          );
        }
      case UrlPage.files:
        {
          var user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _dataCubit,
              child: Files(
                user: user,
              ),
            ),
          );
        }
      case UrlPage.settings:
        {
          return MaterialPageRoute(
            builder: (_) => const Settings(),
          );
        }
      case UrlPage.trash:
        {
          int userId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  TrashCubit(RepositoryModule.trashRepository(), _dataCubit),
              child: Trash(userId: userId),
            ),
          );
        }
      case UrlPage.accountAdd:
        {
          int userId = int.parse(settings.arguments.toString());
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => AccountCubit(
                _dataCubit,
              ),
              child: AccountAdd(userId: userId),
            ),
          );
        }
      case UrlPage.filesAdd:
        {
          return MaterialPageRoute(
            builder: (_) => const FilesAdd(),
          );
        }
      case UrlPage.notesAdd:
        {
          int userId = int.parse(settings.arguments.toString());
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => NotesCubit(
                _dataCubit,
              ),
              child: NotesAdd(userId: userId),
            ),
          );
        }
      case UrlPage.notesShowUpdate:
        {
          ModelNotes.Notes notes = settings.arguments as ModelNotes.Notes;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => NotesCubit(
                _dataCubit,
              ),
              child: NotesShowUpdate(notes: notes),
            ),
          );
        }
      case UrlPage.accountShowUpdate:
        {
          ModelAccount.Account account =
              settings.arguments as ModelAccount.Account;
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => AccountCubit(_dataCubit),
                    child: AccountShowUpdate(account: account),
                  ));
        }
    }
    return null;
  }
}
