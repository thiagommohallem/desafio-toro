import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:toro_app/app/modules/home/domain/errors/quotes.exception.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/presenters/usecases/get_quotes.usecase.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final IGetQuotesUsecase _getQuotesUsecase;
  StreamSubscription? _subscription;

  QuotesBloc(this._getQuotesUsecase) : super(QuotesInitial()) {
    on<Subscribed>((event, emit) async {
      await _subscription?.cancel();
      final _stockQuoteStream = await _getQuotesUsecase();

      _subscription = _stockQuoteStream.listen(
        (stockQuotes) {
          add(StockQuotesReceived(stockQuotes));
        },
        onDone: () => add(
          StockQuotesError(
            const ConnectionClosedException(
                message: 'Conexão fechada, confira se o servidor está ativo'),
          ),
        ),
      );
    });
    on<StockQuotesReceived>(
      (event, emit) {
        emit(StockReceivedSuccess(List.from(event.stockQuotes)));
      },
    );
    on<StockQuotesError>(
      (event, emit) {
        emit(StockReceivedError(event.exception));
      },
    );
  }
  @override
  Future<void> close() {
    if (_subscription != null) _subscription!.cancel();
    _getQuotesUsecase.dispose();
    return super.close();
  }
}
