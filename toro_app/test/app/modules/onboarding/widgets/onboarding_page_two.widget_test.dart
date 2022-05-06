import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/widgets/onboarding_page_two.widget.dart';

void main() {
  group("OnboardingPageTwo widget tests ...", () {
    testWidgets('Should display picture, title and description ...',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPageTwo()));

      final _picture = find.byType(SvgPicture);
      expect(_picture, findsOneWidget);

      final _title = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == "Corretagem Zero" &&
          widget.style ==
              TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]) &&
          widget.textAlign == TextAlign.center);
      expect(_title, findsOneWidget);

      final _description = find.text(
          'Aproveite para investir com Corretagem Zero em qualquer tipo de ativo, inclusive da Bolsa.',
          findRichText: true);
      expect(_description, findsOneWidget);
    });
  });
}
