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
    stockStream.listen((stock) {
      StockQuote stockQuote = StockQuote(
          stockId: stock.id,
          currentPrince: stock.value,
          openPrice: stock.value,
          valuation: 0.0,
          timestamp: stock.timestamp);
      if (stockQuotes.contains(stockQuote)) {
        int indexOfQuote = stockQuotes.indexOf(stockQuote);
        stockQuotes[indexOfQuote]
            .priceHistory
            .add(PriceHistory(timestamp: stock.timestamp, price: stock.value));
        stockQuotes[indexOfQuote].currentPrince = stock.value;
        stockQuotes[indexOfQuote].valuation =
            stockQuotes[indexOfQuote].openPrice != 0
                ? ((stock.value * 100 / stockQuotes[indexOfQuote].openPrice)) -
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
    });
    return _streamController.stream;
  }

  @override
  dispose() {
    _streamController.sink.close();
    _quotesRepository.dispose();
  }
}
