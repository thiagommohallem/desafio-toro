import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/home/domain/errors/quotes.exception.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/presenters/blocs/quotes_bloc.dart';
import 'package:toro_app/app/modules/home/presenters/usecases/get_quotes.usecase.dart';

import 'quotes_bloc_test.mocks.dart';

@GenerateMocks([IGetQuotesUsecase])
void main() {
  final MockIGetQuotesUsecase _usecaseMock = MockIGetQuotesUsecase();

  final List<StockQuote> list = [
    StockQuote(
        stockId: 'stockId',
        currentPrince: 1.0,
        openPrice: 1.0,
        valuation: 1.0,
        timestamp: DateTime(2020, 2, 2))
  ];
  group('QuotesBloc tests ...', () {
    setUp(() {
      when(_usecaseMock.dispose()).thenAnswer((realInvocation) async => true);
    });

    tearDown(() => reset(_usecaseMock));

    test("Initial state should be QuotesInitial", () {
      final bloc = QuotesBloc(_usecaseMock);
      expect(bloc.state, QuotesInitial());
    });

    blocTest<QuotesBloc, QuotesState>(
      "Should emit StockReceivedSuccess after Subscribed event is added and a StockQuote is received",
      build: () => QuotesBloc(_usecaseMock),
      act: (bloc) {
        bloc.add(Subscribed());
      },
      setUp: () {
        when(_usecaseMock())
            .thenAnswer((realInvocation) async => Stream.fromIterable([list]));
      },
      expect: () => [
        StockReceivedSuccess(list),
        const StockReceivedError(ConnectionClosedException(
            message: 'Conexão fechada, confira se o servidor está ativo'))
      ],
    );

    blocTest<QuotesBloc, QuotesState>(
      "Should emit StockReceivedError when StockQuotesError is added",
      build: () => QuotesBloc(_usecaseMock),
      act: (bloc) {
        bloc.add(
            StockQuotesError(const ConnectionClosedException(message: '')));
      },
      expect: () =>
          [const StockReceivedError(ConnectionClosedException(message: ''))],
    );

    blocTest<QuotesBloc, QuotesState>(
      "Should call usecase dispose on dispose",
      build: () => QuotesBloc(_usecaseMock),
      setUp: () {
        when(_usecaseMock.dispose()).thenAnswer((realInvocation) async => true);
      },
      verify: (_) => verify(_usecaseMock.dispose()).called(1),
    );
  });
}
