import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrlServiceImpl implements OpenUrlService {
  @override
  void dispose() {}

  @override
  Future<bool> openUrl({required String url}) async {
    try {
      final Uri _url = Uri.parse(url);
      if (await canLaunchUrl(_url)) {
        return await launchUrl(_url);
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
