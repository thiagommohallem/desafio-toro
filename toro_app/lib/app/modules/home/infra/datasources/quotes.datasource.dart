import 'package:toro_app/app/modules/home/infra/model/stock.model.dart';

abstract class QuotesDatasource {
  Future<Stream<Stock>> retrieveQuotes();
  dispose();
}
