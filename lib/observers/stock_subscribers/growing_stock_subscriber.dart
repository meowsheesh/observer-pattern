import 'package:observerpattern/observers/stock.dart';
import 'package:observerpattern/observers/stock_change_direction.dart';
import 'package:observerpattern/observers/stock_subscriber.dart';

class GrowingStockSubscriber extends StockSubscriber {
  GrowingStockSubscriber() {
    title = 'Growing stocks';
  }

  @override
  void update(Stock stock) {
    if (stock.changeDirection == StockChangeDirection.growing) {
      stockStreamController.add(stock);
    }
  }
}
