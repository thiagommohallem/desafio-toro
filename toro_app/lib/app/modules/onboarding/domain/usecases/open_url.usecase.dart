import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';

abstract class IOpenUrlUsecase {
  Future<bool> call(String url);
}

class OpenUrlUsecase extends Disposable implements IOpenUrlUsecase {
  final OpenUrlService _openUrlService;

  OpenUrlUsecase(this._openUrlService);

  @override
  Future<bool> call(String url) async {
    return await _openUrlService.openUrl(url: url);
  }

  @override
  void dispose() {}
}
