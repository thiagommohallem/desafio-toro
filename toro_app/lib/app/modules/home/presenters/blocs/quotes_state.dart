part of 'quotes_bloc.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();
}

class QuotesInitial extends QuotesState {
  @override
  List<Object?> get props => [];
}

class StockReceivedSuccess extends QuotesState {
  final List<StockQuote> stockQuotes;
  const StockReceivedSuccess(this.stockQuotes);

  @override
  List<Object?> get props => [stockQuotes];
}

class StockReceivedError extends QuotesState {
  final QuotesConnectionException exception;

  const StockReceivedError(this.exception);

  @override
  List<Object?> get props => [exception];
}
