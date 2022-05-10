import 'dart:async';

import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/presenters/usecases/get_quotes.usecase.dart';

class GetQuotesUsecaseImpl implements IGetQuotesUsecase {
  final QuotesRepository _quotesRepository;

  GetQuotesUsecaseImpl(this._quotesRepository);

  List<StockQuote> stockQuotes = [];

  final StreamController<List<StockQuote>> _streamController =
      StreamController<List<StockQuote>>.broadcast();

  @override
  Future<Stream<List<StockQuote>>> call() async {
    final stockStream = await _quotesRepository.retrieveQuotes();
    stockStream.listen((stockQuote) {
      if (stockQuotes.contains(stockQuote)) {
        int indexOfQuote = stockQuotes.indexOf(stockQuote);
        stockQuotes[indexOfQuote].priceHistory.add(PriceHistory(
            timestamp: stockQuote.timestamp, price: stockQuote.currentPrince));
        stockQuotes[indexOfQuote].currentPrince = stockQuote.currentPrince;
        stockQuotes[indexOfQuote].valuation =
            stockQuotes[indexOfQuote].openPrice != 0
                ? ((stockQuote.currentPrince *
                        100 /
                        stockQuotes[indexOfQuote].openPrice)) -
                    100
                : 0;
      } else {
        stockQuotes.add(stockQuote);
      }
      stockQuotes.sort((a, b) {
        if (a.valuation == b.valuation) return 0;
        return b.valuation.compareTo(a.valuation);
      });
      _streamController.sink.add(stockQuotes);
    }, onDone: () {
      _streamController.close();
    }, onError: (_) {
      _streamController.close();
    });
    return _streamController.stream;
  }

  @override
  dispose() {
    _streamController.close();
    _quotesRepository.dispose();
  }
}
