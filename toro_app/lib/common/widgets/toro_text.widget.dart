import 'package:flutter/material.dart';

class ToroTextWidget extends StatelessWidget {
  const ToroTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'toro-text',
      child: Image.asset(
        "lib/common/assets/images/toro_text.png",
        height: 50,
        width: 200,
      ),
    );
  }
}
