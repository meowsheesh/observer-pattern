import 'dart:async';

import 'package:observerpattern/observers/stock_ticker.dart';
import 'package:observerpattern/observers/stock_ticker_symbol.dart';

class GameStopStockTicker extends StockTicker {
  GameStopStockTicker() {
    title = StockTickerSymbol.GME.toShortString();
    stockTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setStock(StockTickerSymbol.GME, 16000, 22000);
      notifySubscribers();
    });
  }
}
