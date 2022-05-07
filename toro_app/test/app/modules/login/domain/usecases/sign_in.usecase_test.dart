import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/login/domain/Errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/infra/auth_repository.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/domain/usecases/sign_in.usecase.dart';

import 'sign_in.usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late final SignInUsecase _usecase;
  final MockAuthRepository _repositoryMock = MockAuthRepository();

  setUpAll(() {
    _usecase = SignInUsecase(_repositoryMock);
  });
  group("SignInUsecase tests...", () {
    test('Should return BannedUserException if user has an id 999...',
        () async {
      when(_repositoryMock.signIn(email: 'email', password: 'password'))
          .thenAnswer((realInvocation) async => Right(User("Thiago", "999")));
      final result =
          await _usecase.signIn(email: 'email', password: 'password');
      result.fold(
          (l) => expect(l.runtimeType, BannedUserException), (r) => null);
    });

    test('Should return normally if user id is different from 999...',
        () async {
      when(_repositoryMock.signIn(email: 'email', password: 'password'))
          .thenAnswer((realInvocation) async => Right(User("Thiago", "123")));
      final result =
          await _usecase.signIn(email: 'email', password: 'password');
      result.fold((l) => expect(l, null), (r) => expect(r, isA<User>()));
    });

    test('Should return exception if repository returns exception...',
        () async {
      when(_repositoryMock.signIn(email: 'email', password: 'password'))
          .thenAnswer((realInvocation) async =>
              Left(UserNotFoundException(message: '')));
      final result =
          await _usecase.signIn(email: 'email', password: 'password');
      result.fold((l) => expect(l.runtimeType, UserNotFoundException),
          (r) => expect(r, null));
    });
  });
}
