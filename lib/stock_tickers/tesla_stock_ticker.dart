import 'dart:async';

import 'package:observerpattern/observers/stock_ticker.dart';
import 'package:observerpattern/observers/stock_ticker_symbol.dart';

class TeslaStockTicker extends StockTicker {
  TeslaStockTicker() {
    title = StockTickerSymbol.TSLA.toShortString();
    stockTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        setStock(StockTickerSymbol.TSLA, 60000, 65000);
        notifySubscribers();
      },
    );
  }
}
