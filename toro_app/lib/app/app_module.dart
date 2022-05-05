import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/module/onboarding.module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: OnboardingModule()),
  ];
}
