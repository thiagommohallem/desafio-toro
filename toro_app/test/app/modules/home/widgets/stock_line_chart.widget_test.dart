import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/widgets/stock_line_chart.widget.dart';

void main() {
  group('StockLineChart widget test ...', () {
    testWidgets('StockLineChart widget test ...', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: StockLineChart(
          stockQuote: StockQuote(
              currentPrince: 10.0,
              openPrice: 10.0,
              stockId: 'CMIG3',
              timestamp: DateTime.now(),
              valuation: 1.0),
        ),
      ));

      final _lineChart = find.byType(LineChart);
      expect(_lineChart, findsOneWidget);
    });
  });
}
