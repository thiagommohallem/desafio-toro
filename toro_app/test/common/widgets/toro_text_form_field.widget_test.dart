import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/common/widgets/toro_text_form_field.widget.dart';

void main() {
  final TextEditingController _textController = TextEditingController();

  setUp(() {
    _textController.text = "";
  });

  group("ToroTextFormFieldWidget tests..", () {
    testWidgets('Should populate controller text on text input',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body:
                ToroTextFormField(label: "label", controller: _textController),
          ),
        ),
      );

      final _textFormField = find.byType(TextFormField);
      expect(_textFormField, findsOneWidget);

      await tester.tap(_textFormField);
      await tester.enterText(_textFormField, "teste");
      expect(_textController.text, "teste");
    });
  });
}
