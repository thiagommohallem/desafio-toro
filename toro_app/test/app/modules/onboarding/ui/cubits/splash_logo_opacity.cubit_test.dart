import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/presenters/cubits/splash_logo_opacity.cubit.dart';

void main() {
  group("SplashTextOpacityCubit tests...", () {
    blocTest<SplashTextOpacityCubit, double>(
      "Cubit emits 5.0 when seeded with 5.0",
      build: () => SplashTextOpacityCubit(),
      act: (bloc) => bloc.setOpacity(5.0),
      expect: () => [5.0],
    );
  });
}
