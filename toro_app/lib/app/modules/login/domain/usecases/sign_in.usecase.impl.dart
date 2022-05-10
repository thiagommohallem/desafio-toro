import 'package:dartz/dartz.dart';

import 'package:toro_app/app/modules/login/domain/errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/infra/auth_repository.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/presenters/usecases/sign_in.usecase.dart';

class SignInUsecaseImpl implements ISignInUsecase {
  final AuthRepository _repository;
  SignInUsecaseImpl(
    this._repository,
  );

  @override
  Future<Either<AuthException, User>> signIn(
      {required String email, required String password}) async {
    final result = await _repository.signIn(email: email, password: password);
    if (result.isRight()) {
      return result.fold((l) => Left(l), (r) {
        if (r.id == "999") {
          return Left(BannedUserException(message: "Usuário desativado"));
        }
        return Right(r);
      });
    }
    return result;
  }

  @override
  dispose() {
    _repository.dispose();
  }
}
