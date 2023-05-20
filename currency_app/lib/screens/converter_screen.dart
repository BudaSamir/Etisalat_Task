import 'package:currency_app/controllers/converter_controller.dart';
import 'package:currency_app/screens/widgets/drop_down.dart';
import 'package:currency_app/services/api_clients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  ApiClient client = ApiClient();
  List<String>? currencies;

  void currencyList() async {
    await client.getCurrencies().then((value) {
      setState(() {
        currencies = value;
      });
    });
  }

  @override
  void initState() {
    currencyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var converter = Provider.of<ConverterController>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /****************************************
             *  ConverterScreen Title Widget Starts * 
            *****************************************/
            const Text(
              "Currency Converter",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            /****************************************
             *  ConverterScreen Title Widget Ends * 
            *****************************************/
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /****************************************
                *  Selecting Currencies Widgets Starts * 
                *****************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropDown(currencies, converter.from, (val) {
                      converter.changeFrom(val);
                    }),
                    FloatingActionButton(
                      onPressed: () {
                        converter.swip();
                      },
                      elevation: 10.0,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.swap_horiz,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    CustomDropDown(currencies, converter.to, (val) {
                      converter.changeTo(val);
                    }),
                  ],
                ),
                /****************************************
                *  Selecting Currencies Widgets Ends * 
                *****************************************/
                const SizedBox(height: 40.0),
                /*******************************************
                *  EnteringConverting Value Widget Starts * 
                ********************************************/
                DecoratedBox(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15,
                    )
                  ]),
                  child: TextField(
                    onSubmitted: (value) {
                      converter.gettingRate(value, client);
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Enter The Value To Convert",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black),
                        border: InputBorder.none),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                /*******************************************
                *  EnteringConverting Value Widget Ends * 
                ********************************************/
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          const Text(
                            "Result Of Converting",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            converter.result,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      )),
    );
  }
}

// () {
//                         String? temp = from;
//                         setState(() {
//                           from = to;
//                           to = temp;
//                         });
//                       }