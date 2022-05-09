import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:toro_app/app/modules/onboarding/presenters/usecases/open_url.usecase.dart';

class OpenUrlUsecaseImpl implements IOpenUrlUsecase {
  final OpenUrlService _openUrlService;

  OpenUrlUsecaseImpl(this._openUrlService);

  @override
  Future<Either<OpenUrlException, bool>> call(String url) async {
    return await _openUrlService.openUrl(url: url);
  }

  @override
  void dispose() {
    _openUrlService.dispose();
  }
}
