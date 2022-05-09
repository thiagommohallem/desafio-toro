import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/login/domain/errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';

abstract class ISignInUsecase {
  Future<Either<AuthException, User>> signIn(
      {required String email, required String password});
  dispose();
}
