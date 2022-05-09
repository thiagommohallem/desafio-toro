import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/login/domain/Errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/infra/datasources/auth_datasource.dart';
import 'package:toro_app/app/modules/login/infra/repository/auth_repository.impl.dart';

import 'auth_repository.impl_test.mocks.dart';

@GenerateMocks([AuthDatasource])
void main() {
  final _dataSourceMock = MockAuthDatasource();
  late final AuthRepositoryImpl _authRepository;

  final _userMapMock = {'name': 'Thiago', 'id': '123'};

  setUpAll(() {
    _authRepository = AuthRepositoryImpl(_dataSourceMock);
  });
  group('AuthRepositoryImpl tests...', () {
    testWidgets('Should return User on success', (tester) async {
      when(_dataSourceMock.signIn(
              login: anyNamed('login'), password: anyNamed('password')))
          .thenAnswer((realInvocation) async => _userMapMock);

      final result =
          await _authRepository.signIn(email: 'email', password: 'password');
      result.fold((l) => expect(l, null), (r) => expect(r, isA<User>()));
    });

    testWidgets('Should return AuthException on error', (tester) async {
      when(_dataSourceMock.signIn(
              login: anyNamed('login'), password: anyNamed('password')))
          .thenThrow(UserNotFoundException(message: 'message'));

      final result =
          await _authRepository.signIn(email: 'email', password: 'password');
      result.fold((l) => expect(l.runtimeType, UserNotFoundException),
          (r) => expect(r, null));
    });

    testWidgets('Should call datasource dispose when disposed', (tester) async {
      when(_dataSourceMock.dispose()).thenAnswer((_) async => true);

      await _authRepository.dispose();
      verify(_dataSourceMock.dispose()).called(1);
    });
  });
}
