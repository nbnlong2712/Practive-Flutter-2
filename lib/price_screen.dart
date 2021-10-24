import 'package:flutter/material.dart';
import 'package:flutter_bitcoin_exchange/constant.dart';
import 'package:flutter/cupertino.dart';

import 'coin_card.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  static const router = "/price-screen";

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCrypto = "USD";
  String crypto = "BTC";
  String value = "--";

  List<DropdownMenuItem<String>> getCurrencyListAndroid() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      list.add(item);
    }
    return list;
  }

  List<Text> getCurrencyListIOS() {
    List<Text> list = [];
    for (String currency in currenciesList) {
      list.add(new Text(currency));
    }
    return list;
  }

  List<CoinCard> getCoinCards() {
    List<CoinCard> list = [];
    for (int i = 0; i < cryptoList.length; i++) {
      getPriceCrypto();
      CoinCard card = CoinCard(crypto: crypto, value: value, currency: selectedCrypto);
      list.add(card);
    }
    return list;
  }

  void getPriceCrypto() async {
    double price = await CoinData().getCoinData(crypto, selectedCrypto);
    setState(() {
      value = price.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    super.initState();
    getPriceCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          "Bitcoin Exchange",
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getCoinCards(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                color: Colors.lightBlueAccent,
                height: 160,
                // child: DropdownButton<String>(
                //   value: selectedCrypto,
                //   dropdownColor: Colors.tealAccent,
                //   items: getCurrencyListAndroid(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedCrypto = value!;
                //     });
                //     // ignore: avoid_print
                //     print(selectedCrypto);
                //   },
                // ),
                child: CupertinoPicker(
                  itemExtent: 31.0,
                  magnification: 1.2,
                  offAxisFraction: 0.6,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedCrypto = currenciesList[value];
                      // ignore: avoid_print
                      print(selectedCrypto);
                      getPriceCrypto();
                    });
                  },
                  children: getCurrencyListIOS(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
