import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/ui/widgets/stock_card.widget.dart';
import 'package:toro_app/app/modules/home/ui/widgets/stock_line_chart.widget.dart';

void main() {
  group('StockCard Widget tests....', () {
    testWidgets('Should display stockId and price', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StockCard(
            stockQuote: StockQuote(
                currentPrince: 10.0,
                openPrice: 10.0,
                stockId: 'CMIG3',
                timestamp: DateTime.now(),
                valuation: 100.0),
          ),
        ),
      );

      final stockId = find.text("CMIG3");
      expect(stockId, findsOneWidget);

      final currentPrice = find.text("R\$" + 10.0.toStringAsFixed(2));
      expect(currentPrice, findsOneWidget);
    });

    testWidgets('Should display chart', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StockCard(
            stockQuote: StockQuote(
                currentPrince: 10.0,
                openPrice: 10.0,
                stockId: 'CMIG3',
                timestamp: DateTime.now(),
                valuation: 100.0),
          ),
        ),
      );

      final chart = find.byType(StockLineChart);

      expect(chart, findsOneWidget);
    });

    testWidgets('Should display green valuation when it is positive',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StockCard(
            stockQuote: StockQuote(
                currentPrince: 10.0,
                openPrice: 10.0,
                stockId: 'CMIG3',
                timestamp: DateTime.now(),
                valuation: 100.0),
          ),
        ),
      );

      final valuation = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "+" + 100.0.toStringAsFixed(2) + "%" &&
            widget.style ==
                TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
      );

      expect(valuation, findsOneWidget);
    });

    testWidgets('Should display red valuation when it is negative',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StockCard(
            stockQuote: StockQuote(
                currentPrince: 10.0,
                openPrice: 10.0,
                stockId: 'CMIG3',
                timestamp: DateTime.now(),
                valuation: -100.0),
          ),
        ),
      );

      final valuation = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == (-100.0).toStringAsFixed(2) + "%" &&
            widget.style ==
                TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
      );

      expect(valuation, findsOneWidget);
    });
  });
}
