import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/widgets/onboarding_page_four.widget.dart';
import 'package:toro_app/colors.dart';

void main() {
  group("OnboardingPageFour widget tests", () {
    testWidgets('Should display picture, title and description ...',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPageFour()));

      final _picture = find.byType(SvgPicture);
      expect(_picture, findsOneWidget);

      final _title = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == "E tem muito mais!" &&
          widget.style ==
              TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]) &&
          widget.textAlign == TextAlign.center);
      expect(_title, findsOneWidget);

      final _checkIcons = find.byWidgetPredicate((widget) =>
          widget is Icon &&
          widget.icon == Icons.check &&
          widget.color == toroPrimaryColor &&
          widget.size == 16);

      expect(_checkIcons, findsNWidgets(3));

      final _recomendationsText = find.text("Recomendações de investimentos.");
      expect(_recomendationsText, findsOneWidget);
      final _beginnerToProText = find.text("Cursos do iniciante ao avançado.");
      expect(_beginnerToProText, findsOneWidget);
      final _investKnowingText =
          find.text("Invista sabendo quanto pode ganhar.");
      expect(_investKnowingText, findsOneWidget);
    });
  });
}
