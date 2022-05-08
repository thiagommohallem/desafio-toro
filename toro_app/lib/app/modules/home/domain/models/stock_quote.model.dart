class StockQuote {
  final String stockId;
  double currentPrince;
  final double openPrice;
  double valuation;
  StockQuote({
    required this.stockId,
    required this.currentPrince,
    required this.openPrice,
    required this.valuation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StockQuote && other.stockId == stockId;
  }

  @override
  int get hashCode {
    return stockId.hashCode;
  }
}
