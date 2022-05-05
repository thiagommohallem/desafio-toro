import 'package:flutter/material.dart';

class ToroLogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const ToroLogoWidget({
    this.width = 70,
    this.height = 70,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'toro-logo',
      child: Image.asset(
        "lib/common/assets/icons/logo_toro.png",
        width: width,
        height: height,
      ),
    );
  }
}
