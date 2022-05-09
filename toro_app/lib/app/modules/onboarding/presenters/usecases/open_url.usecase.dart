import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';

abstract class IOpenUrlUsecase {
  Future<Either<OpenUrlException, bool>> call(String url);
  dispose();
}
