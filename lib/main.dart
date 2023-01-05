import 'dart:async';

import 'package:flutter/material.dart';
import 'package:observerpattern/observers/stock_subscribers/default_stock_subscriber.dart';
import 'package:observerpattern/stock_tickers/gamestop_stock_ticker.dart';
import 'package:observerpattern/stock_tickers/google_stock_ticker.dart';
import 'package:observerpattern/observers/stock_subscribers/growing_stock_subscriber.dart';
import 'package:observerpattern/observers/stock.dart';
import 'package:observerpattern/widgets/stock_row.dart';
import 'package:observerpattern/observers/stock_subscriber.dart';
import 'package:observerpattern/widgets/stock_subscriber_selection.dart';
import 'package:observerpattern/widgets/stock_ticker_model.dart';
import 'package:observerpattern/widgets/stock_ticker_selection.dart';
import 'package:observerpattern/stock_tickers/tesla_stock_ticker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _stockSubscriberList = <StockSubscriber>[
    DefaultStockSubscriber(),
    GrowingStockSubscriber(),
  ];

  final _stockTickers = <StockTickerModel>[
    StockTickerModel(stockTicker: GameStopStockTicker()),
    StockTickerModel(
      stockTicker: GoogleStockTicker(),
    ),
    StockTickerModel(
      stockTicker: TeslaStockTicker(),
    )
  ];

  final _stockEntries = <Stock>[];

  StreamSubscription<Stock>? _stockStreamSubscription;
  StockSubscriber _subscriber = DefaultStockSubscriber();
  int _selectedSubscriberIndex = 0;

  @override
  void initState() {
    _stockStreamSubscription = _subscriber.stockStream.listen(_onStockChange);
    super.initState();
  }

  void _onStockChange(Stock stock) {
    setState(() {
      _stockEntries.add(stock);
    });
  }

  void _setSelectedSubscriberIndex(int? index) {
    for (var ticker in _stockTickers) {
      if (ticker.subscribed) {
        ticker.toggleSubscribed();
        ticker.stockTicker.unsubscribe(_subscriber);
      }
    }
    _stockStreamSubscription?.cancel();

    setState(() {
      _stockEntries.clear();
      _selectedSubscriberIndex = index!;
      _subscriber = _stockSubscriberList[_selectedSubscriberIndex];
      _stockStreamSubscription = _subscriber.stockStream.listen(_onStockChange);
    });
  }

  void _toogleStockTickerSelection(int index) {
    final stockTickerModel = _stockTickers[index];
    final stockTicker = stockTickerModel.stockTicker;

    if (stockTickerModel.subscribed) {
      stockTicker.unsubscribe(_subscriber);
    } else {
      stockTicker.subscribe(_subscriber);
    }

    setState(() {
      stockTickerModel.toggleSubscribed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              StockSubscriberSelection(
                stockSubscriberList: _stockSubscriberList,
                selectedIndex: _selectedSubscriberIndex,
                onChanged: _setSelectedSubscriberIndex,
              ),
              StockTickerSelection(
                  stockTickers: _stockTickers,
                  onChanged: _toogleStockTickerSelection),
              Column(
                children: [
                  for (final stock in _stockEntries.reversed)
                    StockRow(stock: stock)
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
