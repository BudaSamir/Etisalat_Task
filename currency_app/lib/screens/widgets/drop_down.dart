import 'package:flutter/material.dart';

Widget CustomDropDown(
    List<String>? items, String? value, void Function(String?)? onChanged) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0.0, 10.0),
          )
        ]),
    child: DropdownButton(
      elevation: 100,
      value: value,
      onChanged: onChanged,
      items: items?.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
    ),
  );
}
