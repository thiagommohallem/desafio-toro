import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/utils/quotes_quicksort.dart';

void main() {
  group('QuotesQuicksort tests ...', () {
    test('Should return empty list when empty list is passed through parameter',
        () {
      final result = quickSort([], 0, 0);
      expect(result, isEmpty);
    });

    test(
        'Should return list with one element when list with single stock quote is passed through parameter',
        () {
      final result = quickSort(
        [
          StockQuote(
            stockId: 'stockId',
            currentPrince: 10.0,
            openPrice: 10.0,
            valuation: 10.0,
          )
        ],
        0,
        0,
      );
      expect(result.length, 1);
    });

    test(
        'Should return list ordered list by valuation when list with multiple StockQuotes is passed through parameter',
        () {
      final result = quickSort(
        [
          StockQuote(
            stockId: 'stockId',
            currentPrince: 10.0,
            openPrice: 10.0,
            valuation: 10.0,
          ),
          StockQuote(
            stockId: 'stockId2',
            currentPrince: 10.0,
            openPrice: 10.0,
            valuation: 20.0,
          ),
          StockQuote(
            stockId: 'stockId3',
            currentPrince: 10.0,
            openPrice: 10.0,
            valuation: 15.0,
          )
        ],
        0,
        2,
      );
      expect(result.first.stockId, 'stockId2');
      expect(result[1].stockId, 'stockId3');
      expect(result[2].stockId, 'stockId');
    });
  });
}
