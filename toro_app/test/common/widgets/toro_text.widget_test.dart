import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

void main() {
  group("ToroTextWidget tests...", () {
    testWidgets('Should return Text with default values of height and width...',
        (tester) async {
      await tester.pumpWidget(const ToroTextWidget());

      final _heroWidget =
          find.byWidgetPredicate((w) => w is Hero && w.tag == 'toro-text');
      final _textImageAsset = find.byWidgetPredicate(
          (w) => w is Image && w.width == 200 && w.height == 50);

      final _fullTextWidget =
          find.descendant(of: _heroWidget, matching: _textImageAsset);
      expect(_fullTextWidget, findsOneWidget);
    });
  });
}
