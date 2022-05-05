import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';

void main() {
  group("ToroLogoWidget tests...", () {
    testWidgets(
        'Should return Logo with default values of height and width when no parameters are passed...',
        (tester) async {
      await tester.pumpWidget(const ToroLogoWidget());

      final _heroWidget =
          find.byWidgetPredicate((w) => w is Hero && w.tag == 'toro-logo');

      final _imageWidget = find.byWidgetPredicate(
        (widget) =>
            widget is Image && widget.width == 70 && widget.height == 70,
      );

      final _logoWidget =
          find.descendant(of: _heroWidget, matching: _imageWidget);
      expect(_logoWidget, findsOneWidget);
    });

    testWidgets(
        'Should return Logo with height and width passed through parameters...',
        (tester) async {
      await tester.pumpWidget(const ToroLogoWidget(
        height: 75,
        width: 75,
      ));

      final _heroWidget =
          find.byWidgetPredicate((w) => w is Hero && w.tag == 'toro-logo');

      final _imageWidget = find.byWidgetPredicate(
        (widget) =>
            widget is Image && widget.width == 75 && widget.height == 75,
      );

      final _logoWidget =
          find.descendant(of: _heroWidget, matching: _imageWidget);
      expect(_logoWidget, findsOneWidget);
    });
  });
}
