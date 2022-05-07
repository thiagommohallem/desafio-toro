import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/login/helpers/email_validator.dart';

void main() {
  group('Email validator tests...', () {
    test('Should return true on valid email', () {
      expect(isEmailValid('valid@email.com'), true);
    });
    test('Should return false on invalid email', () {
      expect(isEmailValid('notvalid'), false);
      expect(isEmailValid('notvalid@'), false);
      expect(isEmailValid('notvalid@a'), false);
      expect(isEmailValid('notvalid@@a.'), false);
    });
  });
}
