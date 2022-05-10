import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/firebase_options.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      //Caso queira um opt-in para report de crash;
    }
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Modular.to.addListener(() {
      debugPrint("ROTA: ${Modular.to.path} ");
    });
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
