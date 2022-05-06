import 'package:flutter/material.dart';

class ToroTextWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const ToroTextWidget({
    Key? key,
    this.width = 200,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'toro-text',
      child: Image.asset(
        "lib/common/assets/images/toro_text.png",
        height: height,
        width: width,
      ),
    );
  }
}
