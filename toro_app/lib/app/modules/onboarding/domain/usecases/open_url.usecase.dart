import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';

abstract class IOpenUrlUsecase {
  Future<Either<OpenUrlException, bool>> call(String url);
  dispose();
}

class OpenUrlUsecase implements IOpenUrlUsecase {
  final OpenUrlService _openUrlService;

  OpenUrlUsecase(this._openUrlService);

  @override
  Future<Either<OpenUrlException, bool>> call(String url) async {
    return await _openUrlService.openUrl(url: url);
  }

  @override
  void dispose() {
    _openUrlService.dispose();
  }
}
