import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CoinData{
  var coinUrl = "https://rest.coinapi.io/v1/exchangerate";
  var apiKey = "2C00F832-C1F9-4BAD-94BC-336CAD1CE2FC";

  Future getCoinData(String crypto, String selectCurrency) async{
    String requestUrl = "$coinUrl/$crypto/$selectCurrency?apikey=$apiKey";

    //get API
    http.Response response = await http.get(Uri.parse(requestUrl));

    if(response.statusCode == 200)
      {
        //var of decode not String, var is a map
        Map<String, dynamic> decode = jsonDecode(response.body);
        var price = decode['rate'];
        return price;
      }
    else{
      print(response.statusCode);
      throw "Problem with coin API";
    }
  }
}