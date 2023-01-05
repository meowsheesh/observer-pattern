import 'package:observerpattern/observers/stock_ticker.dart';

class StockTickerModel {
  final StockTicker stockTicker;
  bool subscribed = false;

  toggleSubscribed() {
    subscribed = !subscribed;
  }

  StockTickerModel({required this.stockTicker});
}
