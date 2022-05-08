import 'dart:async';

import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/utils/quotes_quicksort.dart';

abstract class IGetQuotesUsecase {
  Future<Stream<List<StockQuote>>> call();
  dispose();
}

class GetQuotesUsecase implements IGetQuotesUsecase {
  final QuotesRepository _quotesRepository;

  GetQuotesUsecase(this._quotesRepository);

  List<StockQuote> stockQuotes = [];

  final StreamController<List<StockQuote>> _streamController =
      StreamController<List<StockQuote>>.broadcast();

  @override
  Future<Stream<List<StockQuote>>> call() async {
    final stockStream = await _quotesRepository.retrieveQuotes();
    stockStream.listen((stock) {
      StockQuote stockQuote = StockQuote(
        stockId: stock.id,
        currentPrince: stock.value,
        openPrice: stock.value,
        valuation: 0.0,
      );
      if (stockQuotes.contains(stockQuote)) {
        int indexOfQuote = stockQuotes.indexOf(stockQuote);
        stockQuotes[indexOfQuote].currentPrince = stock.value;
        stockQuotes[indexOfQuote].valuation =
            stockQuotes[indexOfQuote].openPrice != 0
                ? ((stock.value * 100 / stockQuotes[indexOfQuote].openPrice)) -
                    100
                : 0;
      } else {
        stockQuotes.add(stockQuote);
      }
      quickSort(stockQuotes, 0, stockQuotes.length - 1);
      _streamController.sink.add(stockQuotes);
    });
    return _streamController.stream;
  }

  @override
  dispose() {
    _streamController.sink.close();
    _quotesRepository.dispose();
  }
}
