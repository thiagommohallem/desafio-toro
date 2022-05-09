import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.impl.dart';

import 'open_url.usecase_test.mocks.dart';

@GenerateMocks([OpenUrlService])
void main() {
  late OpenUrlUsecaseImpl _usecase;
  late MockOpenUrlService _mockOpenUrlService;

  setUpAll(() {
    _mockOpenUrlService = MockOpenUrlService();
    _usecase = OpenUrlUsecaseImpl(_mockOpenUrlService);
  });

  tearDownAll(() => _usecase.dispose());
  group('OpenUrlUsecase tests...', () {
    test('Should return Either<OpenUrlException, bool> value ...', () async {
      when(_mockOpenUrlService.openUrl(url: anyNamed("url")))
          .thenAnswer((invocation) async => const Right(true));
      final result = await _usecase('teste.com');
      expect(result, isA<Either<OpenUrlException, bool>>());
    });
  });
}
