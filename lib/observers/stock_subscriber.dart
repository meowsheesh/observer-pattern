import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:observerpattern/observers/stock.dart';

abstract class StockSubscriber {
  late final String title;

  final id = faker.guid.guid();

  // @protected
  final StreamController<Stock> stockStreamController =
      StreamController.broadcast();

  Stream<Stock> get stockStream => stockStreamController.stream;

  void update(Stock stock);
}
