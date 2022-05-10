import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/domain/infra/open_url.service.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.impl.dart';
import 'package:toro_app/app/modules/onboarding/infra/services/open_url_service.impl.dart';
import 'package:toro_app/app/modules/onboarding/presenters/cubits/open_url_cubit.dart';
import 'package:toro_app/app/modules/onboarding/presenters/cubits/page_index.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/onboarding.page.dart';
import 'package:toro_app/app/modules/onboarding/presenters/usecases/open_url.usecase.dart';

class OnboardingModule extends Module {
  static final List<Bind> _repositoriesAndServicesBinds = [
    Bind.lazySingleton<OpenUrlService>((i) => OpenUrlServiceImpl()),
  ];

  static final List<Bind> _usecasesBinds = [
    Bind.lazySingleton<IOpenUrlUsecase>((i) => OpenUrlUsecaseImpl(i())),
  ];

  static final List<Bind> _cubitsBinds = [
    Bind.lazySingleton<PageIndexCubit>((i) => PageIndexCubit()),
    Bind.lazySingleton<OpenToroSignUpUrlCubit>(
        (i) => OpenToroSignUpUrlCubit(i())),
  ];

  @override
  final List<Bind> binds =
      _cubitsBinds + _usecasesBinds + _repositoriesAndServicesBinds;

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const OnboardingPage()),
  ];
}
