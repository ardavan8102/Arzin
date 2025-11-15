import 'package:arzin/Ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arzin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dana',
      ),
      home: const HomePage(),
    );
  }
}