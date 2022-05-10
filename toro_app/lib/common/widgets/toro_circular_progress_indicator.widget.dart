import 'package:flutter/material.dart';
import 'package:toro_app/colors.dart';

class ToroCircularProgressIndicatorWidget extends StatelessWidget {
  const ToroCircularProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(color: toroPrimaryColor);
  }
}
