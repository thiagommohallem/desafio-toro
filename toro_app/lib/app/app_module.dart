import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/module/onboarding.module.dart';
import 'package:toro_app/app/modules/onboarding/ui/onboarding.page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: OnboardingModule()),
    ChildRoute('/onboarding',
        child: (_, __) => OnboardingPage(),
        transition: TransitionType.fadeIn,
        duration: const Duration(seconds: 1, milliseconds: 300))
  ];
}
