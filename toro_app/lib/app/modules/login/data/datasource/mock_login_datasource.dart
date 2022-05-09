import 'package:toro_app/app/modules/login/domain/errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/infra/datasources/auth_datasource.dart';

class MockLoginDatasource implements AuthDatasource {
  @override
  Future<Map<String, dynamic>> signIn(
      {required String login, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (login == 'valido@gmail.com') {
      if (password != '123456') {
        throw IncorrectPasswordException(message: "Senha incorreta");
      }
      return Future.value({'name': 'Thiago', 'id': '123'});
    } else if (login == "banido@gmail.com") {
      return Future.value({'name': 'Thiago', 'id': '999'});
    } else {
      throw UserNotFoundException(
          message: "Não encontramos um usuário cadastrado com esse e-mail");
    }
  }

  @override
  dispose() {}
}
