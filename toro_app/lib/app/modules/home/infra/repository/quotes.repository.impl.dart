import 'dart:async';

import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/infra/datasources/quotes.datasource.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final QuotesDatasource _quotesDatasource;

  QuotesRepositoryImpl(this._quotesDatasource);

  StreamController<StockQuote> streamController =
      StreamController<StockQuote>.broadcast();

  @override
  Future<Stream<StockQuote>> retrieveQuotes() async {
    final quotesStream = await _quotesDatasource.retrieveQuotes();
    quotesStream.listen(
      (event) {
        StockQuote stockQuote = StockQuote(
          stockId: event.id,
          currentPrince: event.value,
          openPrice: event.value,
          valuation: 0.0,
          timestamp: event.timestamp,
        );
        streamController.sink.add(stockQuote);
      },
      onError: (e) {
        streamController.close();
      },
      onDone: () {
        streamController.close();
      },
    );

    return streamController.stream;
  }

  @override
  dispose() {
    streamController.close();
    _quotesDatasource.dispose();
  }
}
