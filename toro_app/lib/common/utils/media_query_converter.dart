import 'package:flutter/material.dart';

double baseHeightConverter(BuildContext context, double desiredHeight) {
  final double deviceHeight = MediaQuery.of(context).size.height;
  const double baseHeight = 667;
  return (deviceHeight * desiredHeight) / baseHeight;
}

double baseWidthConverter(BuildContext context, double desiredWidth) {
  final double deviceWidth = MediaQuery.of(context).size.width;
  const double baseWidth = 375;
  return (deviceWidth * desiredWidth) / baseWidth;
}
