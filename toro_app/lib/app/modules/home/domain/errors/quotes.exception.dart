abstract class QuotesException {
  final String message;

  QuotesException(this.message);
}

class ConnectionFailedException extends QuotesException {
  ConnectionFailedException(String message) : super(message);
}

class ConnectionClosedException extends QuotesException {
  ConnectionClosedException(String message) : super(message);
}
