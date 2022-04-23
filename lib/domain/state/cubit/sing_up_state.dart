part of 'sing_up_cubit.dart';

@immutable
abstract class SingUpState {
  final Confirmation confirmation;
  final bool isSucces;

  const SingUpState({
    required this.confirmation,
    this.isSucces = false,
  });
}

class SingUpInitial extends SingUpState {
  const SingUpInitial({required Confirmation confirmation})
      : super(confirmation: confirmation);
}

class SingUpLoad extends SingUpState {
  const SingUpLoad(Confirmation confirmation)
      : super(confirmation: confirmation);
}

class SingUpResponce extends SingUpState {
  final Confirmation confirmation;
  final bool isSucces;

  const SingUpResponce({
    required this.isSucces,
    required this.confirmation,
  }) : super(confirmation: confirmation);
}
