import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.dart';

class MockOpenUrlService extends Mock implements OpenUrlService {}

void main() {
  late OpenUrlUsecase _usecase;
  late MockOpenUrlService _mockOpenUrlService;

  setUpAll(() {
    _mockOpenUrlService = MockOpenUrlService();
    _usecase = OpenUrlUsecase(_mockOpenUrlService);
  });

  tearDownAll(() => _usecase.dispose());
  group('OpenUrlUsecase tests...', () {
    test('Should return boolean value ...', () async {
      when(() => _mockOpenUrlService.openUrl(url: any(named: "url")))
          .thenAnswer((invocation) async => true);
      final result = await _usecase('teste.com');
      expect(result, isA<bool>());
    });
  });
}
