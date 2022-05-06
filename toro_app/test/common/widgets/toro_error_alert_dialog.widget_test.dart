import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:toro_app/colors.dart';
import 'package:toro_app/common/widgets/toro_error_alert_dialog.widget.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final navigate = ModularNavigateMock();
  setUpAll(() {
    Modular.navigatorDelegate = navigate;
  });

  group("ToroErrorAlertDialog tests...", () {
    testWidgets('Should find alert image ...', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ToroErrorAlertDialog(
          text: Text("teste"),
        ),
      ));

      final _alertImage = find.byWidgetPredicate(((widget) =>
          widget is Image &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.color == toroSecundaryColor));
      expect(_alertImage, findsOneWidget);
    });

    testWidgets('Should widget passed through parameter ...', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ToroErrorAlertDialog(
          text: Text("teste"),
        ),
      ));

      final _parameterWidget = find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == "teste");
      expect(_parameterWidget, findsOneWidget);
    });
    testWidgets('Should find ok text button and call pop when pressed ...',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ToroErrorAlertDialog(
          text: Text("teste"),
        ),
      ));

      final _okActionButton = find.widgetWithText(TextButton, "OK");
      expect(_okActionButton, findsOneWidget);
      await tester.tap(_okActionButton);
      verify(() => navigate.pop()).called(1);
    });
  });
}
