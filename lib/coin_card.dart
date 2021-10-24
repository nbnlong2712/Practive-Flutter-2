import 'dart:ffi';

import 'package:flutter/material.dart';

import 'coin_data.dart';

class CoinCard extends StatefulWidget {
  CoinCard({Key? key, required this.currency, required this.crypto, required this.value})
      : super(key: key);

  String currency;
  String crypto;
  String value;

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "1 " + widget.crypto + " = " + widget.value + " " + widget.currency,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
