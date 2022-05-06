import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';

void main() {
  double valueForTestingOnPressed = 0.0;
  void onPressedCallback() {
    valueForTestingOnPressed = 10.0;
  }

  setUp(() {
    valueForTestingOnPressed = 0.0;
  });

  group('ToroElevatedButtonWidget tests ...', () {
    testWidgets('Should display with child with default parameters',
        (tester) async {
      Widget child = const Text("child");

      await tester.pumpWidget(
        MaterialApp(
          home: ToroElevatedButtonWidget(
            child: child,
            onPressed: onPressedCallback,
          ),
        ),
      );

      final sizedBox = _findSizedBox();
      expect(sizedBox, findsOneWidget);

      final elevatedButton = _findElevatedButton(child);
      expect(elevatedButton, findsOneWidget);

      final toroElevated =
          find.descendant(of: sizedBox, matching: elevatedButton);
      expect(toroElevated, findsOneWidget);
    });

    testWidgets('Should return 10.0 when onPressed is activated',
        (tester) async {
      Widget child = const Text("child");

      await tester.pumpWidget(
        MaterialApp(
          home: ToroElevatedButtonWidget(
            child: child,
            onPressed: onPressedCallback,
          ),
        ),
      );

      final elevatedButton = _findElevatedButton(child);
      expect(elevatedButton, findsOneWidget);

      expect(valueForTestingOnPressed, 0.0);
      await tester.tap(elevatedButton);
      expect(valueForTestingOnPressed, 10.0);
    });
  });
}

Finder _findElevatedButton(Widget child) {
  return find.byWidgetPredicate(
      (widget) => widget is ElevatedButton && widget.child == child);
}

Finder _findSizedBox() {
  return find.byWidgetPredicate(
    (widget) =>
        widget is SizedBox &&
        widget.width == double.infinity &&
        widget.height == 48,
  );
}
