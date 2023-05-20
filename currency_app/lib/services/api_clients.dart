import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyURL = Uri.https("api.exchangerate.host", "latest");

  Future<List<String>> getCurrencies() async {
    http.Response response = await http.get(currencyURL);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Map<String, dynamic> list = data["rates"];
      List<String> currencies = (list.keys).toList();
      return currencies;
    } else {
      throw Exception("Faild to connect API");
    }
  }

  Future<double?> getRate(String? from, String? to) async {
    final Uri ratetURL =
        Uri.https("api.exchangerate.host", "convert", {"from": from, "to": to});

    http.Response response = await http.get(ratetURL);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      double? result = data["result"];
      return result;
    } else {
      throw Exception("Faild to connect API");
    }
  }

  Future<Map<String, dynamic>> getTimeseries(
      String? startDate, String? endDate) async {
    final Uri ratetURL = Uri.https("api.exchangerate.host", "timeseries",
        {"start_date": startDate, "end_date": endDate});

    http.Response response = await http.get(ratetURL);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Map<String, dynamic> result = data["rates"];
      return result;
    } else {
      throw Exception("Faild to connect API");
    }
  }
}
