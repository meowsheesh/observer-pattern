enum StockTickerSymbol {
  GME,
  GOOGL,
  TSLA,
}

extension StockTickerSymbolExtension on StockTickerSymbol {
  String toShortString() => toString().split('.').last;
}
