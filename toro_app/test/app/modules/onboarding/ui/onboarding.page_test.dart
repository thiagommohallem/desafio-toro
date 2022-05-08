import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:toro_app/app/modules/onboarding/module/onboarding.module.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/open_url_cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/page_index.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/onboarding.page.dart';
import 'package:toro_app/app/modules/onboarding/widgets/onboarding_page_two.widget.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';
import 'package:toro_app/common/widgets/toro_error_alert_dialog.widget.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

import 'onboarding.page_test.mocks.dart';

@GenerateMocks([OpenToroSignUpUrlCubit])
void main() {
  final mockOpenUrlCubit = MockOpenToroSignUpUrlCubit();

  setUpAll(() {
    initModule(OnboardingModule(), replaceBinds: [
      Bind<OpenToroSignUpUrlCubit>((_) => mockOpenUrlCubit),
      Bind.factory<PageIndexCubit>((_) => PageIndexCubit()),
    ]);
  });

  setUp(() {
    when(mockOpenUrlCubit.state).thenReturn(OpenUrlInitial());
    when(mockOpenUrlCubit.stream).thenAnswer((_) => Stream.fromIterable([]));
  });
  group('OnboardingPage widget tests...', () {
    testWidgets(
        'Should display logo, text, pageview, dotsIndicator in step 1 and buttons',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
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
      await tester.pumpWidget(const MaterialApp(
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

    testWidgets('Should call openUrl when OpenAccount button is tapped',
        (tester) async {
      when(mockOpenUrlCubit.openUrl()).thenAnswer((invocation) async => {});
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingPage(),
      ));
      final _openAccountButton = _findOpenAccountButton();
      expect(_openAccountButton, findsOneWidget);

      await tester.tap(_openAccountButton);
      await tester.pumpAndSettle();

      verify(mockOpenUrlCubit.openUrl()).called(1);
    });
    testWidgets('Should show error dialog when state is OpenUrlErrorState',
        (tester) async {
      when(mockOpenUrlCubit.state).thenReturn(OpenUrlErrorState());
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingPage(),
      ));
      await tester.pumpAndSettle();
      final errorDialog = find.byWidgetPredicate(
        (w) => w is ToroErrorAlertDialog && w.text is SelectableText,
      );
      expect(errorDialog, findsOneWidget);
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
