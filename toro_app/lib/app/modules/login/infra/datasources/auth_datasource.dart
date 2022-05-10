import 'package:toro_app/app/modules/login/domain/model/user.model.dart';

abstract class AuthDatasource {
  Future<User> signIn({required String login, required String password});
  dispose();
}
