import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/domain/usecases/get_quotes.usecase.impl.dart';

import 'get_quotes.usecase_test.mocks.dart';

@GenerateMocks([QuotesRepository])
void main() {
  late final GetQuotesUsecaseImpl _usecase;
  final MockQuotesRepository _mockRepository = MockQuotesRepository();

  setUpAll(() {
    _usecase = GetQuotesUsecaseImpl(_mockRepository);
  });

  List<StockQuote> _stocksQuotes = [
    StockQuote(
        stockId: '2',
        currentPrince: 15.0,
        openPrice: 15.0,
        valuation: 0.0,
        timestamp: DateTime.now()),
    StockQuote(
        stockId: '1',
        currentPrince: 10.0,
        openPrice: 10.0,
        valuation: 0.0,
        timestamp: DateTime.now()),
    StockQuote(
        stockId: '1',
        currentPrince: 25.0,
        openPrice: 25.0,
        valuation: 0.0,
        timestamp: DateTime.now()),
  ];

  group('GetQuotesUsecase tests...', () {
    test('Should return ordered stockQuotes by valuation...', () async {
      when(_mockRepository.retrieveQuotes())
          .thenAnswer((_) async => Stream.fromIterable(_stocksQuotes));
      List<StockQuote> stockQuotes = [];
      final stream = await _usecase();
      int count = 0;
      stream.listen((event) {
        count++;
        stockQuotes = event;
        if (count == 1) {
          expectLater(stockQuotes.first.stockId, '2');
        }
        if (count == 3) {
          expectLater(stockQuotes.first.stockId, '1');
          expectLater(stockQuotes.length, 2);
        }
      });
    });

    test('Should call repository dispose on dispose...', () {
      when(_mockRepository.dispose()).thenAnswer((_) async => true);
      _usecase.dispose();
      verify(_mockRepository.dispose()).called(1);
    });
  });
}
