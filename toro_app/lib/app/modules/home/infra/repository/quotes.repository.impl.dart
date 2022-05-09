import 'dart:async';

import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/infra/entity/stock.entity.dart';
import 'package:toro_app/app/modules/home/infra/datasources/quotes.datasource.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final QuotesDatasource _quotesDatasource;

  QuotesRepositoryImpl(this._quotesDatasource);

  StreamController<Stock> streamController = StreamController.broadcast();

  @override
  Future<Stream<Stock>> retrieveQuotes() async {
    final quotesStream = await _quotesDatasource.retrieveQuotes();
    quotesStream.listen((event) {
      final stock = Stock.fromJson(event);
      streamController.sink.add(stock);
    });
    return streamController.stream;
  }

  @override
  dispose() {
    streamController.close();
    _quotesDatasource.dispose();
  }
}
