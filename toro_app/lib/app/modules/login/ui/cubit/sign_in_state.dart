part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInError extends SignInState {
  final AuthException exception;
  const SignInError(this.exception);
}

class SignInSuccess extends SignInState {
  final User user;
  const SignInSuccess(this.user);
}
