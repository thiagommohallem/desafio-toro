import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/home/domain/models/stock.model.dart';
import 'package:toro_app/app/modules/home/infra/datasources/quotes.datasource.dart';
import 'package:toro_app/app/modules/home/infra/repository/quotes.repository.impl.dart';

import 'quotes.repository.impl_test.mocks.dart';

@GenerateMocks([QuotesDatasource])
void main() {
  late final QuotesRepositoryImpl _repository;
  final MockQuotesDatasource _mockDatasource = MockQuotesDatasource();

  setUpAll(() {
    _repository = QuotesRepositoryImpl(_mockDatasource);
  });
  group('QuotesRepositoryImpl tests ...', () {
    test('Should convert Json to Stock and return it as Stream<Stock>',
        () async {
      when(_mockDatasource.retrieveQuotes()).thenAnswer(
        (_) async => Stream.fromIterable(
          [
            {
              'id': 'CMIG3',
              'value': 10.0,
              'timestamp': 1652020482,
            }
          ],
        ),
      );
      final stream = await _repository.retrieveQuotes();
      stream.listen((stock) {
        expectLater(stock, isA<Stock>());
      });
    });

    test('Should call datasource dispose on dispose', () async {
      when(_mockDatasource.dispose()).thenAnswer((_) => true);
      _repository.dispose();
      verify(_mockDatasource.dispose()).called(1);
    });
  });
}
