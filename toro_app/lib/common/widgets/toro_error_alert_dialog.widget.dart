import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/colors.dart';

class ToroErrorAlertDialog extends StatelessWidget {
  final Widget text;
  const ToroErrorAlertDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: toroSecundaryColor),
          child: const Text(
            "OK",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Modular.to.pop();
          },
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              'lib/common/assets/icons/info_alert.png',
              width: 40,
              height: 40,
              color: toroSecundaryColor,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          text,
        ],
      ),
    );
  }
}
