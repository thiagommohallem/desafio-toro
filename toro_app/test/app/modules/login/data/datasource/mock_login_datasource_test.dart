import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/login/data/datasource/mock_login_datasource.dart';
import 'package:toro_app/app/modules/login/domain/Errors/auth_exception.dart';

void main() {
  late final MockLoginDatasource _loginDatasource;

  setUpAll(() {
    _loginDatasource = MockLoginDatasource();
  });

  tearDownAll(() => _loginDatasource.dispose());
  group("MockLoginDatasource tests...", () {
    test('Should return valid map on success', () async {
      final result = await _loginDatasource.signIn(
          login: "valido@gmail.com", password: "123456");
      expect(result, isA<Map>());
    });

    test('Should throw UserNotFoundException on error when user is not found',
        () async {
      expect(
        () async => await _loginDatasource.signIn(
            login: "notfound@gmail.com", password: "123456"),
        throwsA(isA<UserNotFoundException>()),
      );
    });

    test(
        'Should throw IncorrectPasswordException on error when password is incorrect',
        () async {
      expect(
        () async => await _loginDatasource.signIn(
            login: "valido@gmail.com", password: "143456"),
        throwsA(isA<IncorrectPasswordException>()),
      );
    });

    test('Should return user with id 999 when e-mail is banido@gmail.com',
        () async {
      final result = await _loginDatasource.signIn(
          login: "banido@gmail.com", password: "123456");
      expect(result, isA<Map>());
      expect(result['id'], '999');
    });
  });
}
