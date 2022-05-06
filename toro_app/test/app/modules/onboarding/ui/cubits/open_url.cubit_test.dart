import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/open_url.cubit.dart';

class MockOpenUrlUsecase extends Mock implements IOpenUrlUsecase {}

void main() {
  MockOpenUrlUsecase _usecaseMock = MockOpenUrlUsecase();
  group("OpenToroSignUpUrlCubit tests...", () {
    blocTest<OpenToroSignUpUrlCubit, bool?>(
      "Emits true when openUrl returns true",
      build: () => OpenToroSignUpUrlCubit(_usecaseMock),
      act: (bloc) => bloc.openUrl(),
      setUp: () {
        when(() => _usecaseMock(any())).thenAnswer((invocation) async => true);
      },
      expect: () => [true],
    );

    blocTest<OpenToroSignUpUrlCubit, bool?>(
      "Emits false when openUrl returns false",
      build: () => OpenToroSignUpUrlCubit(_usecaseMock),
      act: (bloc) => bloc.openUrl(),
      setUp: () {
        when(() => _usecaseMock(any())).thenAnswer((invocation) async => false);
      },
      expect: () => [false],
    );
  });
}
