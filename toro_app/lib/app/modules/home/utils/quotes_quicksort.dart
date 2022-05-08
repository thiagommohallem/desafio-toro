import 'package:toro_app/app/modules/home/domain/models/stock_quote.model.dart';

void swap(List<StockQuote> list, int i, int j) {
  StockQuote temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}

int partition(List<StockQuote> list, low, high) {
  if (list.isEmpty) {
    return 0;
  }
  double pivot = list[high].valuation;
  int i = low - 1;
  for (int j = low; j < high; j++) {
    if (list[j].valuation > pivot) {
      i++;
      swap(list, i, j);
    }
  }
  swap(list, i + 1, high);
  return i + 1;
}

List<StockQuote> quickSort(List<StockQuote> list, int low, int high) {
  if (low < high) {
    int pi = partition(list, low, high);
    quickSort(list, low, pi - 1);
    quickSort(list, pi + 1, high);
  }
  return list;
}
