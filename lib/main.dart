import 'package:flutter/material.dart';
import 'package:google_map/converting_Latlang_to_address.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ConvertingLatlangToAddress(),
    );
  }
}
