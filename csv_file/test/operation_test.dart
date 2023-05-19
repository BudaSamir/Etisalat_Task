import 'package:csv_file/operation.dart';
import 'package:csv_file/order_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  late Operation opTest;
  late String path;
  late String data;
  late List<Order> orders;
  late Map<String, int> brandOrders;

  setUp(() {
    opTest = Operation();
    path = "D:/Work Flutter/Learning/csv_file/lib/test.csv";
    data = opTest.readCsvFile(path);
    orders = opTest.csvToOrdersList(data);
    brandOrders = opTest.brandOrders(orders);
  });

/* 
******************************
  Read Csv File (Test Methods)
******************************
*/
  test("Read Csv file successfully Read it", () {
    // Arrange
    final String expectResult = opTest.readCsvFile(path);

    // Act
    final String result = opTest.readCsvFile(path);

    // Assert
    expect(result, expectResult);
  });

  test("Read Csv file Should Throw an Exception, if The path empty", () {
    // Arrange
    final expectResult = throwsA(isA<Exception>());

    // Act
    result() => opTest.readCsvFile('');

    // Assert
    expect(result, expectResult);
  });

/* 
***********************************
End of Read Csv File (Test Methods)
***********************************
*/

/* 
**********************************************
Convert Csv Data To List<Order> (Test Methods)
**********************************************
*/

  test("csvToProductList Method Should Return List Of Orders successfully", () {
    // Arrange
    final List<String> listOfID = [
      "ID994806",
      "ID644525",
      "ID348204",
      "ID710139",
      "ID426632"
    ];
    final List<String> listOfArea = [
      "Willard Vista",
      "Roger Centers",
      "Roger Centers",
      "Roger Centers",
      "Willa Hollow"
    ];
    final List<String> listOfName = [
      "Intelligent Copper Knife",
      "Intelligent Copper Knife",
      "Small Granite Shoes",
      "Intelligent Copper Knife",
      "Intelligent Copper Knife"
    ];
    final List<int> listOfQuantity = [
      3,
      1,
      4,
      4,
      4,
    ];
    final List<String> listOfBrand = [
      "Hill-Gorczany",
      "Kunze-Bernhard",
      "Row and Legros",
      "Hill-Gorczany",
      "Hill-Gorczany"
    ];
    final expectResult = List.generate(
        5,
        (index) => Order(
              id: listOfID[index],
              area: listOfArea[index],
              name: listOfName[index],
              quantity: listOfQuantity[index],
              brand: listOfBrand[index],
            ));
    // Act
    final result = opTest.csvToOrdersList(data);

    // Assert
    expect(result, expectResult);
  });

  test("csvToProductList Method should Throw an Exception, if The data empty",
      () {
    // Arrange
    final expectResult = throwsA(isA<Exception>());

    // Act
    result() => opTest.csvToOrdersList('');

    // Assert
    expect(result, expectResult);
  });

/* 
*********************************************
End of Csv Data To List<Order> (Test Methods)
*********************************************
*/

/* 
***************************
The Average (Test Methods)
***************************
*/
  test("avg Method Should Return List Of Data successfully", () {
    // Arrange
    final List<List<dynamic>> expectResult = [
      ['Intelligent Copper Knife', 2.4],
      ['Small Granite Shoes', 0.8]
    ];

    // Act
    final result = opTest.avg(orders);

    // Assert
    expect(result, expectResult);
  });

  test("avg Method should Throw an Exception, if The List<Order> empty", () {
    // Arrange
    final expectResult = throwsA(isA<Exception>());

    // Act
    result() => opTest.avg([]);

    // Assert
    expect(result, expectResult);
  });
/* 
*****************************
End Of Average (Test Methods)
*****************************
*/
/* 
********************************************************
The Quantity Of Orders For Selected Brand (Test Methods)
********************************************************
*/

  test("brandOrders Method Should Return Map<String, int> successfully", () {
    // Arrange
    final Map<String, int> expectResult = {
      'Hill-Gorczany': 3,
      'Kunze-Bernhard': 1,
      'Row and Legros': 1
    };

    // Act
    final result = opTest.brandOrders(orders);

    // Assert
    expect(result, expectResult);
  });

  test("brandOrders Method should Throw an Exception, if The orders is empty",
      () {
    // Arrange
    final expectResult = throwsA(isA<Exception>());

    // Act
    result() => opTest.brandOrders([]);

    // Assert
    expect(result, expectResult);
  });

/* 
****************************************************************
 End Of The Quantity Of Orders For Selected Brand (Test Methods)
****************************************************************
*/
/* 
**********************************************************
 The most popular Brand for that product. (Test Methods)
**********************************************************
*/
  test("most Method Should Return List<List<dynamic>> successfully", () {
    // Arrange
    final List<List<dynamic>> expectResult = [
      ['Intelligent Copper Knife', 'Hill-Gorczany'],
      ['Intelligent Copper Knife', 'Kunze-Bernhard'],
      ['Small Granite Shoes', 'Row and Legros']
    ];

    // Act
    final result = opTest.most(orders, brandOrders);

    // Assert
    expect(result, expectResult);
  });

  test(
      "most Method should Throw an Exception, if The orders and brandOrders are empty",
      () {
    // Arrange
    final expectResult = throwsA(isA<Exception>());

    // Act
    result() => opTest.most([], {});

    // Assert
    expect(result, expectResult);
  });

/* 
**************************************************************
 End Of The most popular Brand for that product (Test Methods)
**************************************************************
*/
}
