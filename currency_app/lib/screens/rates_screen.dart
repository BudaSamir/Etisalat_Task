import 'package:currency_app/controllers/converter_controller.dart';
import 'package:currency_app/controllers/rates_controller.dart';
import 'package:currency_app/screens/details.dart';
import 'package:currency_app/services/api_clients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RatesScreen extends StatelessWidget {
  const RatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiClient client = ApiClient();
    var rates = Provider.of<RatesController>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: Column(children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Daily Historical Rates",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                    )
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  rates.showdatePickerFrom(context);
                                },
                                child: const Text("Choose Date From")),
                            Text(
                              DateFormat("yyyy-MM-dd")
                                  .format(rates.dataTimeFrom)
                                  .toString(),
                              style: const TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  rates.showdatePickerTo(context);
                                },
                                child: const Text("Choose Date To")),
                            Text(
                              DateFormat("yyyy-MM-dd")
                                  .format(rates.dataTimeTo)
                                  .toString(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String from = DateFormat("yyyy-MM-dd")
                          .format(rates.dataTimeFrom)
                          .toString();
                      String to = DateFormat("yyyy-MM-dd")
                          .format(rates.dataTimeTo)
                          .toString();
                      rates.setmap(client, from, to);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.search),
                        Text("Search"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          FutureBuilder(
            future: rates.map,
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.done) {
                List<String> days = (data!.keys).toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: days.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                )
                              ]),
                          child: ListTile(
                            title: Text(days[index]),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return DetialsScreen(
                                        dayDetials: data[days[index]],
                                      );
                                    },
                                  ));
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: CupertinoColors.activeBlue,
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ]),
      )),
    );
  }
}
