abstract class QuotesConnectionException {
  final String message;

  QuotesConnectionException({required this.message});
}

class ConnectionClosedException extends QuotesConnectionException {
  ConnectionClosedException({required String message})
      : super(message: message);
}
