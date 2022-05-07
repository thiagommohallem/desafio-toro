abstract class AuthDatasource {
  Future<Map<String, dynamic>> signIn(
      {required String login, required String password});
}
