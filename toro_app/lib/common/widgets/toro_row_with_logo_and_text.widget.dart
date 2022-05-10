import 'package:flutter/material.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

class ToroRowWithLogoAndTextWidget extends StatelessWidget {
  final double? logoWidth;
  final double? logoHeight;
  final double? textWidth;
  final double? textHeight;
  const ToroRowWithLogoAndTextWidget(
      {Key? key,
      this.logoWidth,
      this.logoHeight,
      this.textWidth,
      this.textHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToroLogoWidget(
          width: logoWidth ?? 40,
          height: logoHeight ?? 40,
        ),
        const SizedBox(
          width: 10,
        ),
        ToroTextWidget(
          width: textWidth ?? 110,
          height: textHeight ?? 40,
        )
      ],
    );
  }
}
