import 'package:toro_app/app/modules/login/domain/errors/auth_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/login/domain/infra/auth_repository.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/infra/datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<AuthException, User>> signIn(
      {required String email, required String password}) async {
    try {
      final user = await _datasource.signIn(login: email, password: password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  @override
  dispose() {
    _datasource.dispose();
  }
}
