import 'dart:convert';
import 'dart:developer';

import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class CryptoData {
  static Future<String> _getResp() async {
    final response = await https.get(
      Uri.parse(
          'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,USDT&tsyms=RUB'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Apikey ce68b0146c882316c8f2a3c35c391b41bec94a6f96eba626942cf44c0c37e1e8',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return '';
  }

  Future<List> getData() async {
    String resp = await _getResp();
    var answer = jsonDecode(resp);
    return [
      {
        'name': 'Bitcoin',
        'symbol': 'BTC',
        'icon': CryptoFontIcons.BTC,
        'iconColor': Colors.orange,
        'change': answer['RAW']['BTC']['RUB']['CHANGEPCT24HOUR'].toString(),
        'changeValue': answer['RAW']['BTC']['RUB']['CHANGE24HOUR'].toString(),
        'changeColor': Colors.green,
        'value': answer['RAW']['BTC']['RUB']['PRICE'].toString()+ ' ₽',
      },
      {
        'name': 'Ethereum',
        'symbol': 'ETH',
        'icon': CryptoFontIcons.ETH,
        'iconColor': Colors.black,
        'change': answer['RAW']['ETH']['RUB']['CHANGEPCT24HOUR'].toString(),
        'changeValue': answer['RAW']['ETH']['RUB']['CHANGE24HOUR'].toString(),
        'changeColor': Colors.green,
        'value': answer['RAW']['ETH']['RUB']['PRICE'].toString() + ' ₽'
      },
      {
        'name': 'Tether',
        'symbol': 'USDT',
        'icon': CryptoFontIcons.USDT,
        'iconColor': Colors.black,
        'change': answer['RAW']['USDT']['RUB']['CHANGEPCT24HOUR'].toString(),
        'changeValue': answer['RAW']['USDT']['RUB']['CHANGE24HOUR'].toString(),
        'changeColor': Colors.green,
        'value': answer['RAW']['USDT']['RUB']['PRICE'].toString() + ' ₽'
      }
    ];
  }
}
