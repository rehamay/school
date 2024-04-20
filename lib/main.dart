import 'package:flutter/material.dart';
import 'package:school/splash.dart';
import 'package:school/welcome.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'paymentmethod',
      routes: {
        'welcome':((context)=> Welcome()),
      },
      home: const Splash(),
    );
  }
}
