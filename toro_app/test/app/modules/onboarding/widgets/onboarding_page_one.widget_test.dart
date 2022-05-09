import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/ui/widgets/onboarding_page_one.widget.dart';

void main() {
  group('OnboardingPageOne widget tests ...', () {
    testWidgets('Should display title and picture', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPageOne()));

      final _title = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data ==
                "Olá!\nAgora você tem o jeito mais fácil de investir na Bolsa." &&
            widget.textAlign == TextAlign.center &&
            widget.style ==
                const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      );
      expect(_title, findsOneWidget);

      final _picture = find.byType(SvgPicture);
      expect(_picture, findsOneWidget);
    });
  });
}
