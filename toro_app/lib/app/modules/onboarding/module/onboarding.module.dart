import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/login/module/login.module.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.dart';
import 'package:toro_app/app/modules/onboarding/infra/services/open_url_service.impl.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/open_url_cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/page_index.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/splash_logo_opacity.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/splash.page.dart';

class OnboardingModule extends Module {
  static final List<Bind> _repositoriesAndServicesBinds = [
    Bind.lazySingleton<OpenUrlService>((i) => OpenUrlServiceImpl()),
  ];

  static final List<Bind> _usecasesBinds = [
    Bind.lazySingleton<IOpenUrlUsecase>((i) => OpenUrlUsecase(i())),
  ];

  static final List<Bind> _cubitsBinds = [
    Bind.lazySingleton<PageIndexCubit>((i) => PageIndexCubit()),
    Bind.lazySingleton<SplashTextOpacityCubit>((i) => SplashTextOpacityCubit()),
    Bind.lazySingleton<OpenToroSignUpUrlCubit>(
        (i) => OpenToroSignUpUrlCubit(i())),
  ];

  @override
  final List<Bind> binds =
      _cubitsBinds + _usecasesBinds + _repositoriesAndServicesBinds;

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const SplashPage()),
    ModuleRoute('/login',
        module: LoginModule(),
        transition: TransitionType.fadeIn,
        duration: const Duration(seconds: 1))
  ];
}
