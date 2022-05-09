import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/domain/usecases/get_quotes.usecase.impl.dart';
import 'package:toro_app/app/modules/home/presenters/blocs/quotes_bloc.dart';

import 'quotes_bloc_test.mocks.dart';

@GenerateMocks([GetQuotesUsecaseImpl])
void main() {
  final MockGetQuotesUsecase _usecaseMock = MockGetQuotesUsecase();

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
      expect: () => [StockReceivedSuccess(list)],
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
