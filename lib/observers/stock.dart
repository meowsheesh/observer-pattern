import 'package:observerpattern/observers/stock_change_direction.dart';
import 'package:observerpattern/observers/stock_ticker.dart';
import 'package:observerpattern/observers/stock_ticker_symbol.dart';

class Stock {
  final StockTickerSymbol symbol;
  final StockChangeDirection changeDirection;
  final double price;
  final double changeAmount;

  const Stock(
      {required this.symbol,
      required this.changeDirection,
      required this.price,
      required this.changeAmount});
}
