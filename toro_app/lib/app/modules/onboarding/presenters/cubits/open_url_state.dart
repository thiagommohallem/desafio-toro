part of 'open_url_cubit.dart';

@immutable
abstract class OpenUrlState extends Equatable {}

class OpenUrlInitial extends OpenUrlState {
  @override
  List<Object?> get props => [];
}

class OpenUrlErrorState extends OpenUrlState {
  @override
  List<Object?> get props => [];
}
