import 'package:currency_app/services/api_clients.dart';
import 'package:flutter/material.dart';

class RatesController extends ChangeNotifier {
  Future<Map<String, dynamic>>? map;
  List<String>? days;
  DateTime dataTimeFrom = DateTime.now();
  DateTime dataTimeTo = DateTime.now();

  void showdatePickerFrom(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      dataTimeFrom = value!;
      notifyListeners();
    });
  }

  void showdatePickerTo(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      dataTimeTo = value!;
      notifyListeners();
    });
  }

  Future<Map<String, dynamic>>? setmap(
      ApiClient client, String from, String to) {
    map = client.getTimeseries(from, to);
    notifyListeners();
  }
}
