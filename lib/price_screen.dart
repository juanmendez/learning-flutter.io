import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/models/currency_exchange.dart';

class PriceScreen extends StatefulWidget {
  final List<String> currenciesList;
  final CurrencyExchange currencyExchange;
  final Function onRequestConnection;
  final Function(String) selectCurrency;

  PriceScreen(
    this.currenciesList,
    this.currencyExchange,
    this.onRequestConnection,
    this.selectCurrency,
  );

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  /// I normally write variables which hold widget references,
  /// but for lack of time I didn't do so.
  @override
  void initState() {
    super.initState();
    widget.onRequestConnection();
  }

  Widget getDropdown(Function(String) handler) {
    List<DropdownMenuItem> getDropdownItems() {
      return widget.currenciesList.map((e) {
        return DropdownMenuItem(
          child: Text(e),
          value: e,
        );
      }).toList();
    }

    List<Widget> getPickerItems() {
      return widget.currenciesList.map((e) {
        return Text(
          e,
          style: TextStyle(color: Colors.white),
        );
      }).toList();
    }

    if (Platform.isAndroid) {
      return DropdownButton<String>(
        key: ObjectKey(widget.currenciesList.length),
        items: getDropdownItems(),
        value: widget.currencyExchange?.currency,
        onChanged: handler,
      );
    } else {
      final selectedIndex = widget.currenciesList.indexOf(widget.currencyExchange.currency);

      return CupertinoPicker(
        key: ObjectKey(widget.currenciesList.length),
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (index) => handler(widget.currenciesList[index]),
        children: getPickerItems(),
        scrollController: FixedExtentScrollController(initialItem: selectedIndex),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  'USD? = 1 ${widget.currencyExchange.currency}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(
              child: Text(
            widget.currencyExchange?.rate ?? "select a currency",
            style: TextStyle(color: Colors.black, fontSize: 44),
          )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropdown((currency) {
              setState(() {
                widget.selectCurrency(currency);
              });
            }),
          ),
        ],
      ),
    );
  }
}
