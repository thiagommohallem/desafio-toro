import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/domain/models/stock.model.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/domain/usecases/get_quotes.usecase.dart';

import 'get_quotes.usecase_test.mocks.dart';

@GenerateMocks([QuotesRepository])
void main() {
  late final GetQuotesUsecase _usecase;
  final MockQuotesRepository _mockRepository = MockQuotesRepository();

  setUpAll(() {
    _usecase = GetQuotesUsecase(_mockRepository);
  });

  List<Stock> _stocks = [
    Stock(id: '2', value: 15.0, timestamp: DateTime.now()),
    Stock(id: '1', value: 10.0, timestamp: DateTime.now()),
    Stock(id: '1', value: 25.0, timestamp: DateTime.now()),
  ];

  group('GetQuotesUsecase tests...', () {
    test('Should return ordered stockQuotes by valuation...', () async {
      when(_mockRepository.retrieveQuotes())
          .thenAnswer((_) async => Stream.fromIterable(_stocks));
      List<StockQuote> stockQuotes = [];
      final stream = await _usecase();
      int count = 1;
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
