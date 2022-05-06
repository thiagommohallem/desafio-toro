import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toro_app/common/utils/media_query_converter.dart';

class OnboardingPageTwo extends StatelessWidget {
  const OnboardingPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        _picture(context),
        const Spacer(),
        _title(),
        const Spacer(),
        _description(),
        const Spacer(),
      ],
    );
  }

  SvgPicture _picture(BuildContext context) {
    return SvgPicture.asset(
      'lib/common/assets/images/onboarding_step_2.svg',
      height: baseHeightConverter(context, 200),
    );
  }

  Text _title() {
    return Text(
      "Corretagem Zero",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[700]),
    );
  }

  RichText _description() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        children: const [
          TextSpan(text: "Aproveite para investir com "),
          TextSpan(
              text: "Corretagem Zero em qualquer tipo de ativo,",
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: " inclusive da Bolsa."),
        ],
      ),
    );
  }
}
