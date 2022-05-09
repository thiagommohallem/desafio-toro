import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';

abstract class IGetQuotesUsecase {
  Future<Stream<List<StockQuote>>> call();
  dispose();
}
