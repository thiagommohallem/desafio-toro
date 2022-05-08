import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/open_url_cubit.dart';

import 'open_url.cubit_test.mocks.dart';

@GenerateMocks([IOpenUrlUsecase])
void main() {
  final _usecaseMock = MockIOpenUrlUsecase();

  setUpAll(() {
    when(_usecaseMock.dispose()).thenAnswer((realInvocation) async => true);
  });
  group("OpenToroSignUpUrlCubit tests...", () {
    blocTest<OpenToroSignUpUrlCubit, OpenUrlState>(
      "Emits true when openUrl returns true",
      build: () => OpenToroSignUpUrlCubit(_usecaseMock),
      act: (bloc) => bloc.openUrl(),
      setUp: () {
        when(_usecaseMock(any))
            .thenAnswer((invocation) async => const Right(true));
      },
      expect: () => [OpenUrlInitial()],
    );

    blocTest<OpenToroSignUpUrlCubit, OpenUrlState>(
      "Emits false when openUrl returns false",
      build: () => OpenToroSignUpUrlCubit(_usecaseMock),
      act: (bloc) => bloc.openUrl(),
      setUp: () {
        when(_usecaseMock(any))
            .thenAnswer((invocation) async => const Right(false));
      },
      expect: () => [OpenUrlErrorState()],
    );
    blocTest<OpenToroSignUpUrlCubit, OpenUrlState>(
      "Emits false when openUrl has an Exception",
      build: () => OpenToroSignUpUrlCubit(_usecaseMock),
      act: (bloc) => bloc.openUrl(),
      setUp: () {
        when(_usecaseMock(any))
            .thenAnswer((invocation) async => Left(OpenUrlException()));
      },
      expect: () => [OpenUrlErrorState()],
    );
  });
}
