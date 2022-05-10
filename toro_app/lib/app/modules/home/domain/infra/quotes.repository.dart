import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';

abstract class QuotesRepository {
  Future<Stream<StockQuote>> retrieveQuotes();
  dispose();
}
