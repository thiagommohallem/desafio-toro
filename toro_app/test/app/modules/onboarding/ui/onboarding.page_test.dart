import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:toro_app/app/modules/onboarding/module/onboarding.module.dart';
import 'package:toro_app/app/modules/onboarding/ui/onboarding.page.dart';
import 'package:toro_app/app/modules/onboarding/widgets/onboarding_page_two.widget.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

void main() {
  setUp(() {
    initModule(OnboardingModule());
  });
  group('OnboardingPage widget tests...', () {
    testWidgets(
        'Should display logo, text, pageview, dotsIndicator in step 1 and buttons',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: OnboardingPage(),
      ));
      final _toroLogo = find.byWidgetPredicate(
        (widget) =>
            widget is ToroLogoWidget &&
            widget.width == 50 &&
            widget.height == 50,
      );
      expect(_toroLogo, findsOneWidget);

      final _toroText = find.byWidgetPredicate(
        (widget) =>
            widget is ToroTextWidget &&
            widget.width == 150 &&
            widget.height == 50,
      );
      expect(_toroText, findsOneWidget);

      final _pageView = find.byType(PageView);
      expect(_pageView, findsOneWidget);

      final _dotsIndicatorInStep1 = _findDotIndicatorByPosition(0.0);
      expect(_dotsIndicatorInStep1, findsOneWidget);

      final _openAccountButton = _findOpenAccountButton();
      expect(_openAccountButton, findsOneWidget);
      final _loginButton = _findLoginButton();
      expect(_loginButton, findsOneWidget);
    });

    testWidgets('Should change dots indicator when pageview is scrolled',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: OnboardingPage(),
      ));

      final _dotsIndicatorInStep1 = _findDotIndicatorByPosition(0.0);
      expect(_dotsIndicatorInStep1, findsOneWidget);
      final _pageView = find.byType(PageView);
      expect(_pageView, findsOneWidget);
      await tester.dragUntilVisible(
        find.byType(OnboardingPageTwo),
        _pageView,
        const Offset(-50, 0),
      );
      await tester.pumpAndSettle();

      final _dotsIndicatorInStep2 = _findDotIndicatorByPosition(1.0);
      expect(_dotsIndicatorInStep2, findsOneWidget);
    });
  });
}

Finder _findLoginButton() =>
    find.widgetWithText(ToroElevatedButtonWidget, "Entrar");

Finder _findOpenAccountButton() {
  return find.widgetWithText(ToroElevatedButtonWidget, "Abra sua conta grátis");
}

Finder _findDotIndicatorByPosition(double position) {
  return find.byWidgetPredicate((widget) =>
      widget is DotsIndicator &&
      widget.dotsCount == 4 &&
      widget.position == position);
}
