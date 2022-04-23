import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart';
import 'package:passmanager_diplom/domain/model/validation_auth.dart';
import 'package:passmanager_diplom/domain/repository/auth_repository.dart';

part 'sing_up_state.dart';

class SingUpCubit extends Cubit<SingUpState> {
  SingUpCubit(this._authRepository)
      : super(
          SingUpInitial(
              confirmation: Confirmation(
                  number: 0,
                  userName: '',
                  login: '',
                  password: '',
                  validationAuth: ValidationAuth(
                      login: null, password: null, userName: null))),
        );

  final AuthRepository _authRepository;

  void singUp({
    required String userName,
    required String login,
    required String password,
  }) async {
    emit(SingUpLoad(state.confirmation));
    var value = await _authRepository.confirmation(
      userName: userName,
      login: login,
      password: password,
    );

    emit(SingUpResponce(
      isSucces: false,
      confirmation: value,
    ));

    if (value.number != 0) {
      emit(SingUpResponce(
        isSucces: true,
        confirmation: value,
      ));
    }
  }
}
