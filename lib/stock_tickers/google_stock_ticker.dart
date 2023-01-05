import 'dart:async';

import 'package:observerpattern/observers/stock_ticker.dart';
import 'package:observerpattern/observers/stock_ticker_symbol.dart';

class GoogleStockTicker extends StockTicker {
  GoogleStockTicker() {
    title = StockTickerSymbol.GOOGL.toShortString();
    stockTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        setStock(StockTickerSymbol.GOOGL, 200000, 204000);
        notifySubscribers();
      },
    );
  }
}
