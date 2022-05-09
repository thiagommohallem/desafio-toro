import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toro_app/common/utils/media_query_converter.dart';

class OnboardingPageOne extends StatelessWidget {
  const OnboardingPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        _title(),
        const Spacer(),
        _picture(context),
      ],
    );
  }

  Text _title() {
    return const Text(
      "Olá!\nAgora você tem o jeito mais fácil de investir na Bolsa.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    );
  }

  SvgPicture _picture(BuildContext context) {
    return SvgPicture.asset(
      'lib/common/assets/images/onboarding_step_1.svg',
      height: baseHeightConverter(context, 200),
    );
  }
}
