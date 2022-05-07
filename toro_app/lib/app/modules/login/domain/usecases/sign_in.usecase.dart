import 'package:dartz/dartz.dart';

import 'package:toro_app/app/modules/login/domain/Errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/infra/auth_repository.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';

abstract class ISignInUsecase {
  Future<Either<AuthException, User>> signIn(
      {required String email, required String password});
}

class SignInUsecase implements ISignInUsecase {
  final AuthRepository _repository;
  SignInUsecase(
    this._repository,
  );

  @override
  Future<Either<AuthException, User>> signIn(
      {required String email, required String password}) async {
    final result = await _repository.signIn(email: email, password: password);
    if (result.isRight()) {
      result.fold((l) => null, (r) {
        if (r.id == "999") {
          return Left(BannedUserException(message: "Usuário desativado"));
        }
      });
    }
    return result;
  }
}
