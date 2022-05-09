class StockQuote {
  final String stockId;
  double currentPrince;
  final double openPrice;
  double valuation;
  List<PriceHistory> priceHistory;
  final DateTime timestamp;

  StockQuote(
      {required this.stockId,
      required this.currentPrince,
      required this.openPrice,
      required this.valuation,
      required this.timestamp})
      : priceHistory = [
          PriceHistory(timestamp: timestamp, price: currentPrince)
        ];

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

class PriceHistory {
  final DateTime timestamp;
  final double price;

  PriceHistory({required this.timestamp, required this.price});
}
