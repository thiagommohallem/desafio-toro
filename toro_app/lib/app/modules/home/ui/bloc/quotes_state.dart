part of 'quotes_bloc.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();
  @override
  List<Object?> get props => [];
}

class QuotesInitial extends QuotesState {}

class StockReceivedSuccess extends QuotesState {
  final List<StockQuote> stockQuotes;
  const StockReceivedSuccess(this.stockQuotes);

  @override
  List<Object?> get props => [stockQuotes];
}
