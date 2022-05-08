import 'package:toro_app/app/modules/home/domain/models/stock.model.dart';

abstract class QuotesRepository {
  Future<Stream<Stock>> retrieveQuotes();
  dispose();
}
