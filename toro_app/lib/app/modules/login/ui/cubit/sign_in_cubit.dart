import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:toro_app/app/modules/login/domain/Errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/domain/usecases/sign_in.usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUsecase _usecase;
  SignInCubit(this._usecase) : super(SignInInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());
    final result = await _usecase.signIn(email: email, password: password);
    result.fold(
      (l) {
        emit(SignInError(l));
      },
      (r) => emit(SignInSuccess(r)),
    );
  }

  void returnToInitialState() => emit(SignInInitial());
}
