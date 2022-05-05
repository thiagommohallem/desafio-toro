import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/ui/splash.page.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

void main() {
  group("SplashPage tests...", () {
    testWidgets('Should display Logo and Text after animations',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashPage()));
      await tester.pumpAndSettle();

      final _logo = find.byType(ToroLogoWidget);
      expect(_logo, findsOneWidget);
      final _toroText = find.byType(ToroTextWidget);
      expect(_toroText, findsOneWidget);
    });
  });
}
