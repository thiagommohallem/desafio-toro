import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/widgets/onboarding_page_three.widget.dart';

void main() {
  group("OnboardingPageThree widget tests", () {
    testWidgets('Should display picture, title and description ...',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPageThree()));

      final _picture = find.byType(SvgPicture);
      expect(_picture, findsOneWidget);

      final _title = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == "Cashback em Fundos de Investimento" &&
          widget.style ==
              TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]) &&
          widget.textAlign == TextAlign.center);
      expect(_title, findsOneWidget);

      final _description = find.text(
          'Receba parte da taxa de administração, em dinheiro, direto na sua conta Toro.',
          findRichText: true);
      expect(_description, findsOneWidget);
    });
  });
}
