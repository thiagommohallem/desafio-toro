import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/home/data/datasource/quotes.datasource.impl.dart';
import 'package:toro_app/app/modules/home/domain/infra/quotes.repository.dart';
import 'package:toro_app/app/modules/home/domain/usecases/get_quotes.usecase.impl.dart';
import 'package:toro_app/app/modules/home/infra/datasources/quotes.datasource.dart';
import 'package:toro_app/app/modules/home/infra/repository/quotes.repository.impl.dart';
import 'package:toro_app/app/modules/home/presenters/blocs/quotes_bloc.dart';
import 'package:toro_app/app/modules/home/presenters/usecases/get_quotes.usecase.dart';
import 'package:toro_app/app/modules/home/ui/home.page.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeModule extends Module {
  static final List<Bind> _dataSourcesBinds = [
    Bind.lazySingleton<QuotesDatasource>((i) => QuotesDatasourceImpl(
        WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:8080/quotes')))),
  ];
  static final List<Bind> _repositoriesAndServicesBinds = [
    Bind.lazySingleton<QuotesRepository>((i) => QuotesRepositoryImpl(i())),
  ];

  static final List<Bind> _usecasesBinds = [
    Bind.lazySingleton<IGetQuotesUsecase>((i) => GetQuotesUsecaseImpl(i())),
  ];

  static final List<Bind> _blocBinds = [
    Bind.lazySingleton<QuotesBloc>((i) => QuotesBloc(i())),
  ];

  @override
  final List<Bind> binds = _blocBinds +
      _usecasesBinds +
      _repositoriesAndServicesBinds +
      _dataSourcesBinds;

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage()),
  ];
}
