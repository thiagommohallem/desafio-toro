import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/home/infra/model/stock.model.dart';

void main() {
  group('Stock model tests ...', () {
    test('Should return valid Stock on creation', () {
      final model =
          Stock(id: 'id', value: 12.0, timestamp: DateTime(2022, 1, 1));
      expect(model.id, 'id');
      expect(model.value, 12.0);
      expect(model.timestamp, DateTime(2022, 1, 1));
    });
    test('Should return valid Stock fromJson', () {
      final model = Stock.fromJson({
        'id': 'id',
        'value': 12.0,
        'timestamp': DateTime(2022, 1, 1).millisecondsSinceEpoch
      });
      expect(model.id, 'id');
      expect(model.value, 12);
      expect(model.timestamp, DateTime(2022, 1, 1));
    });
  });
}
