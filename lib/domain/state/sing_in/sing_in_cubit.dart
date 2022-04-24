import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';
import 'package:passmanager_diplom/domain/repository/crud_reposittiry.dart';

part 'sing_in_state.dart';

class SingInCubit extends Cubit<SingInState> {
  SingInCubit(this._authRepository, this._crudRepository)
      : super(SingInInitial());
  final AuthRepository _authRepository;
  final CRUDRepository _crudRepository;

  void SingIn({
    required String login,
    required String password,
  }) async {
    emit(SingInLoad());
    var user = await _authRepository.singIn(login: login, password: password);

    if (user.id == 0) {
      emit(SingInResponce(user: user, isSucces: false));
    } else {
      _crudRepository.create(user: user);
      emit(SingInResponce(user: user, isSucces: true));
    }
  }
}
