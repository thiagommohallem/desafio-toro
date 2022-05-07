import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/login/data/datasource/mock_login_datasource.dart';
import 'package:toro_app/app/modules/login/domain/infra/auth_repository.dart';
import 'package:toro_app/app/modules/login/domain/usecases/sign_in.usecase.dart';
import 'package:toro_app/app/modules/login/infra/datasources/auth_datasource.dart';
import 'package:toro_app/app/modules/login/infra/repository/auth_repository.impl.dart';
import 'package:toro_app/app/modules/login/ui/cubit/sign_in_cubit.dart';
import 'package:toro_app/app/modules/login/ui/login.page.dart';

class LoginModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<AuthDatasource>((i) => MockLoginDatasource()),
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(i())),
        Bind.lazySingleton<SignInUsecase>((i) => SignInUsecase(i())),
        Bind.lazySingleton<SignInCubit>((i) => SignInCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => LoginPage()),
      ];
}
