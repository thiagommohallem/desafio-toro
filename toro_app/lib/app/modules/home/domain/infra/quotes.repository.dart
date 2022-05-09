import 'package:toro_app/app/modules/home/infra/entity/stock.entity.dart';

abstract class QuotesRepository {
  Future<Stream<Stock>> retrieveQuotes();
  dispose();
}
