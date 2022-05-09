import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';

void main() {
  group('StockQuote model tests ...', () {
    test('Should return valid StockQuote on creation ...', () {
      final model = StockQuote(
          currentPrince: 10.0,
          openPrice: 5.0,
          stockId: 'id',
          valuation: 10.0,
          timestamp: DateTime(2020, 2, 2));
      expect(model.currentPrince, 10.0);
      expect(model.openPrice, 5.0);
      expect(model.stockId, 'id');
      expect(model.valuation, 10.0);
    });
    test('Should return equality StockQuote based on stockId ...', () {
      final model = StockQuote(
          currentPrince: 10.0,
          openPrice: 5.0,
          stockId: 'stockId2',
          valuation: 10.0,
          timestamp: DateTime(2020, 2, 2));
      final model2 = StockQuote(
          currentPrince: 10.0,
          openPrice: 5.0,
          stockId: 'stockId',
          valuation: 10.0,
          timestamp: DateTime(2020, 2, 2));
      final model3 = StockQuote(
          currentPrince: 10.0,
          openPrice: 5.0,
          stockId: 'stockId',
          valuation: 10.0,
          timestamp: DateTime(2020, 2, 2));
      expect(model3 == model2, true);
      expect(model == model2, false);
      expect(model == model3, false);
    });
  });
}
