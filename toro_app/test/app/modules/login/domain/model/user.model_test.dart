import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';

void main() {
  group("User model tests...", () {
    test('Should create valid user', () {
      User user = User('name', '123');
      expect(user.name, 'name');
      expect(user.id, "123");
    });
    test('Should create valid user from json', () {
      User user = User.fromJson({'name': 'name', 'id': 'id'});
      expect(user.name, 'name');
      expect(user.id, "id");
    });
  });
}
