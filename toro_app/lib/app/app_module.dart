import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/home/module/home.module.dart';
import 'package:toro_app/app/modules/login/module/login.module.dart';
import 'package:toro_app/app/modules/onboarding/module/onboarding.module.dart';
import 'package:toro_app/app/splash/presenter/splash_logo_opacity.cubit.dart';
import 'package:toro_app/app/splash/ui/splash.page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<SplashTextOpacityCubit>((i) => SplashTextOpacityCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const SplashPage()),
    ModuleRoute('/onboarding',
        module: OnboardingModule(),
        transition: TransitionType.fadeIn,
        duration: const Duration(seconds: 1, milliseconds: 300)),
    ModuleRoute('/login',
        module: LoginModule(),
        transition: TransitionType.fadeIn,
        duration: const Duration(seconds: 1, milliseconds: 300)),
    ModuleRoute('/home',
        module: HomeModule(),
        transition: TransitionType.fadeIn,
        duration: const Duration(seconds: 1, milliseconds: 300)),
  ];
}
