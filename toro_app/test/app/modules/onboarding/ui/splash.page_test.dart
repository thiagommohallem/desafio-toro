import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:toro_app/app/modules/onboarding/module/onboarding.module.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/splash_logo_opacity.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/splash.page.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final navigate = ModularNavigateMock();

  setUpAll(() {
    Modular.navigatorDelegate = navigate;
    initModule(OnboardingModule(), replaceBinds: [
      Bind.factory<SplashTextOpacityCubit>((i) => SplashTextOpacityCubit()),
    ]);
    when(() => navigate.pushNamed(any()))
        .thenAnswer((invocation) async => true);
  });

  group("SplashPage tests...", () {
    testWidgets('Should display Logo and Text after animations',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashPage()));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final _logo = find.byType(ToroLogoWidget);
      expect(_logo, findsOneWidget);
      final _toroText = find.byType(ToroTextWidget);
      expect(_toroText, findsOneWidget);
    });
    testWidgets('Should push Onboarding page after 3 seconds', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashPage()));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      verify(() => navigate.pushNamed('/onboarding'));
    });
  });
}
