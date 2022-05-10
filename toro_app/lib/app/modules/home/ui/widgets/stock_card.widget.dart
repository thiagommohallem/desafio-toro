import 'package:flutter/material.dart';
import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';
import 'package:toro_app/app/modules/home/ui/widgets/stock_line_chart.widget.dart';
import 'package:toro_app/common/utils/media_query_converter.dart';

class StockCard extends StatelessWidget {
  final StockQuote stockQuote;
  const StockCard({Key? key, required this.stockQuote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        height: 130,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _stockIdWithCurrentPriceColumn(context),
            SizedBox(
              width: baseWidthConverter(context, 5),
            ),
            SizedBox(
              width: baseWidthConverter(context, 110),
              child: StockLineChart(stockQuote: stockQuote),
            ),
            const Spacer(),
            const SizedBox(
              width: 7,
            ),
            _valuation(context),
          ],
        ),
      ),
    );
  }

  SizedBox _stockIdWithCurrentPriceColumn(BuildContext context) {
    return SizedBox(
      width: baseWidthConverter(context, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stockQuote.stockId,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          FittedBox(
            child: Text("R\$" + stockQuote.currentPrince.toStringAsFixed(2),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ],
      ),
    );
  }

  SizedBox _valuation(BuildContext context) {
    return SizedBox(
      width: baseWidthConverter(context, 80),
      child: Center(
        child: FittedBox(
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
      ),
    );
  }
}
