import 'dart:io';
import 'package:csv/csv.dart';
import 'package:csv_file/order_model.dart';

class Operation {
/* 
  *************************************
    Read Csv File Method
  *************************************
*/
  String readCsvFile(String path) {
    if (path.isNotEmpty) {
      final File file = File(path);
      return file.readAsStringSync();
    } else {
      throw Exception();
    }
  }

/* 
  ******************************
   End of Read Csv File Method
  ******************************
*/

/* 
  ******************************************
   Convert Csv Data To List<Order> Method
  ******************************************
*/

  List<Order> csvToOrdersList(String data) {
    if (data.isNotEmpty) {
      List<Order> orders = [];
      List<String> _orders = data.split("\n");
      for (int i = 1; i < _orders.length; i++) {
        List<String> order = _orders[i].split(",");
        orders.add(Order(
            id: order[0].trim(),
            area: order[1].trim(),
            name: order[2].trim(),
            quantity: int.parse(order[3].trim()),
            brand: order[4].trim()));
      }
      return orders;
    } else {
      throw Exception();
    }
  }

/* 
  **************************************
   End of Csv Data To List<Order> Method
  **************************************
*/

/* 
*************************************
  The Average Quantity Of 
  The product purchased per order.
*************************************
*/

  List<List<dynamic>> avg(List<Order> orders) {
    if (orders.isNotEmpty) {
      // That Map Will Contain The Prodcut name and it's Average
      Map<String, dynamic> avg = {}; // will fill from THe loop

      // this loop will Select The Products by Names
      // then Store it in a var to use it in the nested loop
      for (int i = 0; i < orders.length; i++) {
        int sum = 0;
        double average = 0.0;
        String prod = orders[i].name;
        // this loop will Search about The quantity of The Selected Prodcut
        // then Sum All quantity of The Selected Prodcut
        // then find The average of The Selected Prodcut
        for (int i = 0; i < orders.length; i++) {
          if (prod == orders[i].name) {
            sum = sum + orders[i].quantity;
          }
          average = sum / orders.length;
          // fill The map
          avg[prod] = average;
        }
      }
      // convert The map to list for csv file
      List<List<dynamic>> list =
          avg.entries.map((entry) => [entry.key, entry.value]).toList();

      return list;
    } else {
      throw Exception();
    }
  }

/* 
****************************
  End Of Average Method
****************************
*/

/* 
*********************************************
  The Quantity Of Orders For Selected Brand
*********************************************
*/

  Map<String, int> brandOrders(List<Order> orders) {
    if (orders.isNotEmpty) {
      // This map store The brand name and The Quantity Of Orders For this brand
      Map<String, int> mostBrand = {};
      // this loop Selected a brand and pass it for the nested loop
      for (int i = 0; i < orders.length; i++) {
        // counter for Orders
        int order = 0;
        // brand name
        String brand = orders[i].brand;
        // this loop Search about The brand in the order
        // then increase the counter if it find an order have the brand name
        for (int i = 0; i < orders.length; i++) {
          if (brand == orders[i].brand) {
            order++;
          }
          // fill The Map With the brand name and  Quantity Of Orders for it
          mostBrand[brand] = order;
        }
      }

      return mostBrand;
    } else {
      throw Exception();
    }
  }

/* 
**************************************************
  End Of The Quantity Of Orders For Selected Brand
**************************************************
*/

/* 
*******************************************************************
The most popular Brand for that product. 
Most popular is defined as the brand
with the most total orders for the item, not the quantity purchased.
********************************************************************
*/
  List<List<dynamic>> most(List<Order> orders, Map<String, int> brandOrders) {
    if (orders.isNotEmpty && brandOrders.isNotEmpty) {
      // this List colect all brand's Order number
      List<int> mostValue = [];
      // this List colect all brand's name
      List<String> mostKey = [];
      // fill The lists
      brandOrders.forEach((key, value) {
        mostKey.add(key);
        mostValue.add(value);
      });

      // bubble Sort
      // this loop Sorting The Brand List (mostKey) and The Order list (mostvalue)
      // Descending
      for (int pass = 1; pass < mostValue.length; pass++) {
        for (int i = 0; i < mostValue.length - pass; i++) {
          int num;
          String txt;
          if (mostValue[i] < mostValue[i + 1]) {
            num = mostValue[i + 1];
            mostValue[i + 1] = mostValue[i];
            mostValue[i] = num;
            txt = mostKey[i + 1];
            mostKey[i + 1] = mostKey[i];
            mostKey[i] = txt;
          }
        }
      }

      // This map store The Product and The most Brand order from it
      Map<String, String> mostBrand = {};

      // this loop search about brand name and pass it for nested loop
      for (int i = 0; i < mostKey.length; i++) {
        String brand = mostKey[i];
        // this loop search about products name for the most brand
        for (int j = 0; j < orders.length; j++) {
          if (brand == orders[j].brand) {
            mostBrand[brand] = orders[j].name;
          }
        }
      }
      // converting the map to List for csv file
      List<List<dynamic>> list =
          mostBrand.entries.map((entry) => [entry.value, entry.key]).toList();

      return list;
    } else {
      throw Exception();
    }
  }

/* 
**************************************************
  End Of The most popular Brand for that product
**************************************************
*/

/* 
*********************************************
  create CSV File
*********************************************
*/

  void createCSVFile(List<List<dynamic>> data, String name) {
    // The file name of CSV file
    String fileName = "$name.csv";
    // The path of the file
    String path = 'D:/Work Flutter/Learning/csv_file/lib';

    // create a new file
    File file = File('$path/$fileName');

    // open the file for writing
    IOSink sink = file.openWrite();

    // write the data to the file
    for (List<dynamic> row in data) {
      String line = row.map((e) => e.toString()).join(',');
      sink.writeln(line);
    }

    // close the file
    sink.close();

    print('CSV file created successfully.');
  }

/* 
**************************************************
  End Of   create CSV File
**************************************************
*/

}
