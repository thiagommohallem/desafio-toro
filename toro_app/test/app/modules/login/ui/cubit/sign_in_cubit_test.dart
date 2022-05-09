import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/login/domain/errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/domain/usecases/sign_in.usecase.impl.dart';
import 'package:toro_app/app/modules/login/presenters/cubits/sign_in_cubit.dart';

class MockSignInUsecase implements SignInUsecaseImpl {
  @override
  Future<Either<AuthException, User>> signIn(
      {String? email, String? password}) {
    if (email == 'email') {
      return Future.value(Right(User('Thiago', '123')));
    } else {
      return Future.value(Left(UserNotFoundException(message: 'message')));
    }
  }

  @override
  dispose() {}
}

void main() {
  final MockSignInUsecase mockSignInUsecase = MockSignInUsecase();
  blocTest<SignInCubit, SignInState>(
    "Should emit SignInSuccess on usecase success",
    build: () => SignInCubit(mockSignInUsecase),
    act: (bloc) {
      bloc.signIn(email: 'email', password: 'password');
    },
    expect: () => [SignInLoading(), SignInSuccess(User('Thiago', '123'))],
  );

  blocTest<SignInCubit, SignInState>(
    "Should emit SignInSuccess on usecase exception",
    build: () => SignInCubit(mockSignInUsecase),
    act: (bloc) {
      bloc.signIn(email: 'invalid', password: 'password');
    },
    expect: () => [
      SignInLoading(),
      SignInError(UserNotFoundException(message: 'message'))
    ],
  );

  blocTest<SignInCubit, SignInState>(
    "Should emit SignInInitial on returnToInitial call",
    build: () => SignInCubit(mockSignInUsecase),
    act: (bloc) {
      bloc.returnToInitialState();
    },
    expect: () => [SignInInitial()],
  );
}
