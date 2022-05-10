import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';

class StockLineChart extends StatelessWidget {
  final StockQuote stockQuote;
  const StockLineChart({
    Key? key,
    required this.stockQuote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        clipData:
            FlClipData(top: true, bottom: false, left: false, right: true),
        minX: stockQuote.priceHistory.first.timestamp.millisecondsSinceEpoch
            .toDouble(),
        maxX: stockQuote.priceHistory.last.timestamp
            .add(const Duration(seconds: 1))
            .millisecondsSinceEpoch
            .toDouble(),
        minY: 0,
        titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            leftTitles: AxisTitles(),
            bottomTitles: AxisTitles()),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: false),
        lineBarsData: [
          LineChartBarData(
            color: Colors.green,
            dotData: FlDotData(show: false),
            spots: stockQuote.priceHistory
                .map((e) => FlSpot(
                    (e.timestamp.millisecondsSinceEpoch).toDouble(), e.price))
                .toList(),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.withOpacity(0.3),
            ),
          )
        ],
      ),
      swapAnimationDuration: const Duration(seconds: 0),
    );
  }
}
