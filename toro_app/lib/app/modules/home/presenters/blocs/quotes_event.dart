part of 'quotes_bloc.dart';

abstract class QuotesEvent {
  const QuotesEvent();
}

class Subscribed extends QuotesEvent {}

class StockQuotesReceived extends QuotesEvent {
  final List<StockQuote> stockQuotes;
  const StockQuotesReceived(this.stockQuotes);
}

class StockQuotesError extends QuotesEvent {
  final QuotesConnectionException exception;

  StockQuotesError(this.exception);
}
