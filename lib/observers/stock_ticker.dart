import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:observerpattern/observers/stock.dart';
import 'package:observerpattern/observers/stock_change_direction.dart';
import 'package:observerpattern/observers/stock_subscriber.dart';
import 'package:observerpattern/observers/stock_ticker_symbol.dart';

abstract class StockTicker {
  late final String title;
  late final Timer stockTimer;

  // @protected
  Stock? stock;

  final _subscribers = <StockSubscriber>[];

  void subscribe(StockSubscriber subscriber) => _subscribers.add(subscriber);

  void unsubscribe(StockSubscriber subscriber) =>
      _subscribers.removeWhere((element) => element.id == subscriber.id);

  void notifySubscribers() {
    for (var subscriber in _subscribers) {
      subscriber.update(stock!);
    }
  }

  void setStock(StockTickerSymbol stockTickerSymbol, int min, int max) {
    final lastStock = stock;
    final price = faker.randomGenerator.integer(max, min: min) / 100;
    final changeAmount = lastStock != null ? price - lastStock.price : 0.0;

    stock = Stock(
      changeAmount: changeAmount.abs(),
      changeDirection: changeAmount > 0
          ? StockChangeDirection.growing
          : StockChangeDirection.falling,
      price: price,
      symbol: stockTickerSymbol,
    );

    void stopTicker() {
      stockTimer.cancel();
    }
  }
}
