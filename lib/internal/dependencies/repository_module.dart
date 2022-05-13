import 'package:passmanager_diplom/domain/repository/auth_data_repository.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_account_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_data_account_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_data_notes_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_data_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_notes_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_reposittiry.dart';
import 'package:passmanager_diplom/domain/repository/data_data_repository.dart';
import 'package:passmanager_diplom/domain/repository/data_repository.dart';
import 'package:passmanager_diplom/domain/repository/information_data_repository.dart';
import 'package:passmanager_diplom/domain/repository/information_repository.dart';
import 'package:passmanager_diplom/domain/repository/trash_data_repository.dart';
import 'package:passmanager_diplom/domain/repository/trash_repository.dart';
import 'package:passmanager_diplom/internal/dependencies/api_module.dart';

class RepositoryModule {
  static AuthRepository? _authRepository;
  static CRUDRepository? _crudRepository;
  static CRUDNotesRepository? _crudNotesRepository;
  static CRUDAccountRepository? _crudAccountRepository;
  static DataRepository? _dataRepository;
  static TrashRepository? _trashRepository;
  static InformationRepository? _informationRepository;

  static AuthRepository authRepository() {
    _authRepository ??= AuthDataRepository(ApiModule.apiUtil());
    return _authRepository!;
  }

  static CRUDRepository crudRepository() {
    _crudRepository ??= CRUDDataRepository();
    return _crudRepository!;
  }

  static CRUDNotesRepository crudNotesRepository() {
    _crudNotesRepository ??= CRUDDataNotesRepository(ApiModule.apiUtil());
    return _crudNotesRepository!;
  }

  static CRUDAccountRepository crudAccountRepository() {
    _crudAccountRepository ??= CRUDDataAccountRepository(ApiModule.apiUtil());
    return _crudAccountRepository!;
  }

  static DataRepository dataRepository() {
    _dataRepository ??= DataDataRepository(ApiModule.apiUtil());
    return _dataRepository!;
  }

  static TrashRepository trashRepository() {
    _trashRepository ??= TrashDataRepository(ApiModule.apiUtil());
    return _trashRepository!;
  }

  static InformationRepository infromationRepository() {
    _informationRepository ??= InformationDataRepository(ApiModule.apiUtil());
    return _informationRepository!;
  }
}
