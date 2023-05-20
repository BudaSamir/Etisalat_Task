import 'package:currency_app/services/api_clients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConverterController extends ChangeNotifier {
  List<String>? currencies;
  String? from;
  String? to;
  double? rate;
  String result = "";

  void currencyList(ApiClient client) async {
    await client.getCurrencies().then((value) {
      currencies = value;
      notifyListeners();
    });
  }

  void gettingRate(value, ApiClient client) async {
    await client.getRate(from, to).then((val) {
      rate = val;
      notifyListeners();
    });
    result = (rate! * double.parse(value)).toStringAsFixed(3);
    notifyListeners();
  }

  void swip() {
    String? temp = from;
    from = to;
    to = temp;
    notifyListeners();
  }

  changeFrom(val) {
    from = val;
    notifyListeners();
  }

  changeTo(val) {
    to = val;
    notifyListeners();
  }
}
