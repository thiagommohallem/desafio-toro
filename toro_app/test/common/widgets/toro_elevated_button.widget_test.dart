import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';

void main() {
  group('ToroElevatedButtonWidget tests ...', () {
    testWidgets('Should display with child with default parameters',
        (tester) async {
      Widget child = const Text("child");

      await tester.pumpWidget(
        MaterialApp(
          home: ToroElevatedButtonWidget(
            child: child,
          ),
        ),
      );

      final sizedBox = find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox &&
            widget.width == double.infinity &&
            widget.height == 48,
      );
      expect(sizedBox, findsOneWidget);

      final elevatedButton = find.byWidgetPredicate(
          (widget) => widget is ElevatedButton && widget.child == child);
      expect(elevatedButton, findsOneWidget);

      final toroElevated =
          find.descendant(of: sizedBox, matching: elevatedButton);
      expect(toroElevated, findsOneWidget);
    });
  });
}
