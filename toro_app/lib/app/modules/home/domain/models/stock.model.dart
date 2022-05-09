class Stock {
  String id;
  double value;
  DateTime timestamp;
  Stock({
    required this.id,
    required this.value,
    required this.timestamp,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      value: json['value'],
      timestamp: DateTime.fromMillisecondsSinceEpoch((json['timestamp'])),
    );
  }
}
