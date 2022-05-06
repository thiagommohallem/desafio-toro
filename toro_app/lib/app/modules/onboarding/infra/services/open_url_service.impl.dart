import 'package:dartz/dartz.dart';
import 'package:toro_app/app/modules/onboarding/domain/errors/open_url_exception.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrlServiceImpl implements OpenUrlService {
  @override
  void dispose() {}

  @override
  Future<Either<OpenUrlException, bool>> openUrl({required String url}) async {
    try {
      final Uri _url = Uri.parse(url);
      if (await canLaunchUrl(_url)) {
        return right(await launchUrl(_url));
      }
      return right(false);
    } catch (e) {
      return left(
          OpenUrlException(errorMessage: "Não foi possível abrir a url: $e"));
    }
  }
}
