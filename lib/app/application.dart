import 'package:flutter/material.dart';
import 'package:joao_foxbit_test/app/navigator.dart';

class FoxbitApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foxbit Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      routes: appRoutes,
    );
  }
}