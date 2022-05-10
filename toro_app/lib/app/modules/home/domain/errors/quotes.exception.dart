import 'package:equatable/equatable.dart';

abstract class QuotesConnectionException extends Equatable {
  final String message;

  const QuotesConnectionException({required this.message});
}

class ConnectionClosedException extends QuotesConnectionException {
  const ConnectionClosedException({required String message})
      : super(message: message); // coverage:ignore-line

  @override
  List<Object?> get props => [message];
}
