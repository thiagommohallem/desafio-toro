part of 'quotes_bloc.dart';

abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class Subscribed extends QuotesEvent {
  @override
  List<Object> get props => [];
}

class StockQuotesReceived extends QuotesEvent {
  final List<StockQuote> stockQuotes;
  const StockQuotesReceived(this.stockQuotes);
  @override
  List<Object> get props => [stockQuotes];
}
