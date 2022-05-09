import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/presenters/blocs/quotes_bloc.dart';
import 'package:toro_app/app/modules/home/ui/widgets/stock_line_chart.widget.dart';
import 'package:toro_app/colors.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

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
          title: _logoAndToroText(),
          elevation: 0.0,
          bottom: TabBar(
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
              ]),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
            top: 16,
          ),
          child: BlocBuilder<QuotesBloc, QuotesState>(
            bloc: _quotesBloc,
            builder: (_, state) {
              return TabBarView(children: [
                if (state is StockReceivedSuccess) ...[
                  _stockListViewTop5(state.stockQuotes),
                ] else ...[
                  const Center(
                      child: CircularProgressIndicator(color: toroPrimaryColor))
                ],
                if (state is StockReceivedSuccess) ...[
                  _stockListViewTop5(state.stockQuotes,
                      isAscendingOrder: false),
                ] else ...[
                  const Center(
                      child: CircularProgressIndicator(color: toroPrimaryColor))
                ]
              ]);
            },
          ),
        ),
      ),
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

  Widget _stockListViewTop5(List<StockQuote> stockQuotes,
      {bool isAscendingOrder = true}) {
    return ListView.builder(
      itemCount: stockQuotes.length < 5 ? stockQuotes.length : 5,
      itemBuilder: (_, index) {
        late final StockQuote stockQuote;
        if (isAscendingOrder) {
          stockQuote = stockQuotes[index];
        } else {
          stockQuote = stockQuotes[stockQuotes.length - index - 1];
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: _stockCard(stockQuote),
          ),
        );
      },
    );
  }

  Card _stockCard(StockQuote stockQuote) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        height: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stockQuote.stockId,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Spacer(),
                  FittedBox(
                    child: Text(
                        "R\$" + stockQuote.currentPrince.toStringAsFixed(2),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: StockLineChart(stockQuote: stockQuote),
            ),
            const SizedBox(
              width: 10,
            ),
            Center(
              child: Text(
                stockQuote.valuation > 0
                    ? "+" + stockQuote.valuation.toStringAsFixed(2) + "%"
                    : stockQuote.valuation.toStringAsFixed(2) + "%",
                style: TextStyle(
                  color: stockQuote.valuation > 0 ? Colors.green : Colors.red,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _logoAndToroText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ToroLogoWidget(
          width: 40,
          height: 40,
        ),
        SizedBox(
          width: 10,
        ),
        ToroTextWidget(
          width: 110,
          height: 40,
        )
      ],
    );
  }

  @override
  void dispose() {
    _quotesBloc.close();
    super.dispose();
  }
}
