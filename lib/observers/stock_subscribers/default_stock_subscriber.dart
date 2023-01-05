import 'package:observerpattern/observers/stock.dart';
import 'package:observerpattern/observers/stock_subscriber.dart';

class DefaultStockSubscriber extends StockSubscriber {
  DefaultStockSubscriber() {
    title = 'All stocks';
  }

  @override
  void update(Stock stock) {
    stockStreamController.add(stock);
  }
}
