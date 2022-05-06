import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';

abstract class OpenUrlService {
  Future<Either<OpenUrlException, bool>> openUrl({required String url});
  void dispose();
}
