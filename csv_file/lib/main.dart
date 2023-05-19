import 'dart:io';

import 'package:csv_file/operation.dart';
import 'package:csv_file/order_model.dart';

void main() {
  Operation op = Operation();
  // Read The CSV file Then Store it
  String data =
      op.readCsvFile("D:/Work Flutter/Learning/csv_file/lib/test.csv");
  // convert The Csv file data from String to List of models
  List<Order> productData = op.csvToOrdersList(data);
  // Calculate The Average Quantity Of The product purchased per order.
  List<List<dynamic>> prodcutsAvg = op.avg(productData);
  // The most popular Brand for The product
  List<List<dynamic>> mostBrand =
      op.most(productData, op.brandOrders(productData));
  // receiving form User CSV Files Name
  stdout.writeln("Enter The files Names");
  String? filesName = stdin.readLineSync();
  // convert from List of data to Csv file data (String)
  // then Export CSV file
  op.createCSVFile(prodcutsAvg, '0_$filesName');
  op.createCSVFile(mostBrand, '1_$filesName');
}
