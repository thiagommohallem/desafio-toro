import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toro_app/colors.dart';
import 'package:toro_app/common/utils/media_query_converter.dart';

class OnboardingPageFour extends StatelessWidget {
  const OnboardingPageFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      'lib/common/assets/images/onboarding_step_4.svg',
      height: baseHeightConverter(context, 200),
    );
  }

  Text _title() {
    return Text(
      "E tem muito mais!",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 24, color: Colors.grey[700], fontWeight: FontWeight.bold),
    );
  }

  Align _description() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          _rowWithCheckAndText("Recomendações de investimentos."),
          const SizedBox(
            height: 10,
          ),
          _rowWithCheckAndText("Cursos do iniciante ao avançado."),
          const SizedBox(
            height: 10,
          ),
          _rowWithCheckAndText("Invista sabendo quanto pode ganhar."),
        ],
      ),
    );
  }

  Row _rowWithCheckAndText(String text) {
    return Row(
      children: [
        const Icon(
          Icons.check,
          color: toroPrimaryColor,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(text, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
