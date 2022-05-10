import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:toro_app/app/modules/home/domain/errors/quotes.exception.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/module/home.module.dart';
import 'package:toro_app/app/modules/home/presenters/blocs/quotes_bloc.dart';
import 'package:toro_app/app/modules/home/ui/home.page.dart';
import 'package:toro_app/app/modules/home/ui/widgets/stock_card.widget.dart';
import 'package:toro_app/common/widgets/toro_circular_progress_indicator.widget.dart';
import 'package:toro_app/common/widgets/toro_row_with_logo_and_text.widget.dart';

import 'home.page_test.mocks.dart';

@GenerateMocks([QuotesBloc])
void main() {
  final MockQuotesBloc _mockQuotesBloc = MockQuotesBloc();

  setUpAll(() {
    initModule(HomeModule(), replaceBinds: [
      Bind.factory<QuotesBloc>((_) => _mockQuotesBloc),
    ]);

    when(_mockQuotesBloc.stream)
        .thenAnswer((realInvocation) => Stream.fromIterable([]));
  });

  group("HomePage tests...", () {
    testWidgets('Should display appbar with loading on quotes initial state',
        (tester) async {
      when(_mockQuotesBloc.state).thenReturn(QuotesInitial());
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final _toroTextAndLogo = find.byType(ToroRowWithLogoAndTextWidget);
      expect(_toroTextAndLogo, findsOneWidget);

      final firstTab = find.descendant(
          of: find.byType(Tab), matching: find.text("Melhor Valorização"));
      expect(firstTab, findsOneWidget);
      final secondTab = find.descendant(
          of: find.byType(Tab), matching: find.text("Pior Valorização"));
      expect(secondTab, findsOneWidget);

      final _loading = find.byType(ToroCircularProgressIndicatorWidget);
      expect(_loading, findsOneWidget);
    });

    testWidgets('Should display message on error state', (tester) async {
      when(_mockQuotesBloc.state).thenReturn(
          const StockReceivedError(ConnectionClosedException(message: 'test')));
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final _errorText =
          find.text("test\n\nReinicie a aplicação para tentar novamente");
      expect(_errorText, findsOneWidget);
    });

    testWidgets('Should display ListView with stock cards on success',
        (tester) async {
      when(_mockQuotesBloc.state).thenReturn(StockReceivedSuccess([
        StockQuote(
          stockId: "stock1",
          currentPrince: 2.0,
          openPrice: 11.1,
          valuation: 1.0,
          timestamp: DateTime.now(),
        ),
        StockQuote(
          stockId: "stock2",
          currentPrince: 2.0,
          openPrice: 11.1,
          valuation: 2.0,
          timestamp: DateTime.now(),
        ),
        StockQuote(
          stockId: "stock3",
          currentPrince: 2.0,
          openPrice: 11.1,
          valuation: 3.0,
          timestamp: DateTime.now(),
        ),
        StockQuote(
          stockId: "stock4",
          currentPrince: 2.0,
          openPrice: 11.1,
          valuation: 4.0,
          timestamp: DateTime.now(),
        ),
        StockQuote(
          stockId: "stock5",
          currentPrince: 2.0,
          openPrice: 11.1,
          valuation: 5.0,
          timestamp: DateTime.now(),
        ),
      ]));

      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final _stockCards = find.byType(StockCard, skipOffstage: false);
      expect(_stockCards, findsNWidgets(5));

      final _listView = find.byType(ListView);
      expect(_listView, findsOneWidget);
    });
  });
}
