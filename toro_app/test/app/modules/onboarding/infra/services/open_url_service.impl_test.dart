import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';
import 'package:toro_app/app/modules/onboarding/infra/services/open_url_service.impl.dart';

void main() {
  late OpenUrlServiceImpl _openUrlService;
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    _openUrlService = OpenUrlServiceImpl();
  });

  tearDownAll(() => _openUrlService.dispose());
  group("OpenUrlServiceImpl tests... ", () {
    test('Should return false when canLaunch url returns false', () async {
      const MethodChannel('plugins.flutter.io/url_launcher_macos')
          .setMockMethodCallHandler((MethodCall call) {
        if (call.method == 'canLaunch') {
          return Future.value(false);
        }
        return Future.value(null);
      });

      final result = await _openUrlService.openUrl(url: "teste.com");
      result.fold((l) {}, (r) => expect(r, false));
    });

    test(
        'Should return true when canLaunch url returns true and launchUrl is called with success',
        () async {
      const MethodChannel('plugins.flutter.io/url_launcher_macos')
          .setMockMethodCallHandler((MethodCall call) {
        if (call.method == 'canLaunch') {
          return Future.value(true);
        }
        if (call.method == 'launch') {
          return Future.value(true);
        }
        return Future.value(null);
      });
      final result = await _openUrlService.openUrl(url: "teste.com");
      result.fold((l) {}, (r) => expect(r, true));
    });

    test('Should return OpenUrlException on exception', () async {
      const MethodChannel('plugins.flutter.io/url_launcher_macos')
          .setMockMethodCallHandler((MethodCall call) {
        if (call.method == 'canLaunch') {
          return Future.value(Exception());
        }
        return Future.value(null);
      });
      final result = await _openUrlService.openUrl(url: "teste.com");
      result.fold((l) {
        expect(l, isA<OpenUrlException>());
      }, (r) {});
    });
  });
}
