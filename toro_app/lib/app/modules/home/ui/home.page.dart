import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/presenters/blocs/quotes_bloc.dart';
import 'package:toro_app/app/modules/home/ui/widgets/stock_card.widget.dart';
import 'package:toro_app/colors.dart';
import 'package:toro_app/common/widgets/toro_circular_progress_indicator.widget.dart';
import 'package:toro_app/common/widgets/toro_row_with_logo_and_text.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuotesBloc _quotesBloc = Modular.get();

  @override
  void initState() {
    super.initState();
    _quotesBloc.add(Subscribed());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const ToroRowWithLogoAndTextWidget(),
          elevation: 0.0,
          bottom: _tabBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
            top: 16,
          ),
          child: _body(context),
        ),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      indicatorPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.black54,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: toroPrimaryColor,
      ),
      tabs: [
        _appBarTab("Melhor Valorização"),
        _appBarTab("Pior Valorização"),
      ],
    );
  }

  Tab _appBarTab(String title) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }

  BlocBuilder<QuotesBloc, QuotesState> _body(BuildContext context) {
    return BlocBuilder<QuotesBloc, QuotesState>(
      bloc: _quotesBloc,
      builder: (_, state) {
        return TabBarView(children: [
          if (state is StockReceivedSuccess) ...[
            _stockListViewTop5(state.stockQuotes),
            _stockListViewTop5(
              state.stockQuotes,
              showMostValuablesStocks: false,
            ),
          ] else if (state is StockReceivedError) ...[
            _connectionErrorText(state.exception.message),
            _connectionErrorText(state.exception.message),
          ] else ...[
            _loading(),
            _loading(),
          ],
        ]);
      },
    );
  }

  Widget _stockListViewTop5(List<StockQuote> stockQuotes,
      {bool showMostValuablesStocks = true}) {
    return ListView.builder(
      itemCount: stockQuotes.length < 5 ? stockQuotes.length : 5,
      itemBuilder: (_, index) {
        late final StockQuote stockQuote;
        if (showMostValuablesStocks) {
          stockQuote = stockQuotes[index];
        } else {
          stockQuote = stockQuotes[stockQuotes.length - index - 1];
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: StockCard(stockQuote: stockQuote),
          ),
        );
      },
    );
  }

  Center _connectionErrorText(String error) {
    return Center(
      child: Text(
        "$error\n\nReinicie a aplicação para tentar novamente",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Center _loading() =>
      const Center(child: ToroCircularProgressIndicatorWidget());

  @override
  void dispose() {
    _quotesBloc.close();
    super.dispose();
  }
}
