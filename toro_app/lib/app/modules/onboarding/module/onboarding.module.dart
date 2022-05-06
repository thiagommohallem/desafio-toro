import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/page_index.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/splash_logo_opacity.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/splash.page.dart';

class OnboardingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<PageIndexCubit>((i) => PageIndexCubit()),
    Bind.lazySingleton<SplashTextOpacityCubit>((i) => SplashTextOpacityCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const SplashPage()),
  ];
}
