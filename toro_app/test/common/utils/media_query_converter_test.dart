import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/common/utils/media_query_converter.dart';

void main() {
  group("MediaQueryConverter tests...", () {
    testWidgets('Convert desiredWidth using baseWidth ...', (tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(),
        child: Builder(builder: ((context) {
          final width = baseWidthConverter(context, 200);
          expect(width, isA<double>());
          expect(width != 200, true);
          return Container();
        })),
      ));
    });

    testWidgets('Convert desiredHeight using baseHeight ...', (tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(),
        child: Builder(builder: ((context) {
          final height = baseHeightConverter(context, 200);
          expect(height, isA<double>());
          expect(height != 200, true);
          return Container();
        })),
      ));
    });
  });
}
