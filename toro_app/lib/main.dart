import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Modular.to.addListener(() {
      debugPrint("ROTA: ${Modular.to.path} ");
    });
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  }, (error, stack) {
    //METODO QUE LOGA OS ERROS
    //Ex: FirebaseCrashlytics.instance.recordError(error, stack)
  });
}
