// Mocks generated by Mockito 5.1.0 from annotations
// in toro_app/test/app/modules/home/ui/bloc/quotes_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart'
    as _i3;
import 'package:toro_app/app/modules/home/domain/usecases/get_quotes.usecase.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [GetQuotesUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetQuotesUsecase extends _i1.Mock implements _i2.GetQuotesUsecase {
  MockGetQuotesUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.StockQuote> get stockQuotes =>
      (super.noSuchMethod(Invocation.getter(#stockQuotes),
          returnValue: <_i3.StockQuote>[]) as List<_i3.StockQuote>);
  @override
  set stockQuotes(List<_i3.StockQuote>? _stockQuotes) =>
      super.noSuchMethod(Invocation.setter(#stockQuotes, _stockQuotes),
          returnValueForMissingStub: null);
  @override
  _i4.Future<_i4.Stream<List<_i3.StockQuote>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue: Future<_i4.Stream<List<_i3.StockQuote>>>.value(
                  Stream<List<_i3.StockQuote>>.empty()))
          as _i4.Future<_i4.Stream<List<_i3.StockQuote>>>);
}
