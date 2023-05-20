// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetialsScreen extends StatelessWidget {
  final Map<String, dynamic> dayDetials;
  const DetialsScreen({
    Key? key,
    required this.dayDetials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List curr = (dayDetials.keys).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.activeBlue,
      ),
      body: SizedBox(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            child: ListView.builder(
              itemCount: curr.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 7.5),
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
                      child: ListTile(
                        title: Text(curr[index]),
                        trailing: Text(dayDetials[curr[index]].toString()),
                      )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
