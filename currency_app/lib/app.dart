import 'dart:ui';

import 'package:currency_app/controllers/converter_controller.dart';
import 'package:currency_app/controllers/rates_controller.dart';
import 'package:currency_app/screens/converter_screen.dart';
import 'package:currency_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConverterController()),
        ChangeNotifierProvider(create: (context) => RatesController()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
      ),
    );
  }
}
