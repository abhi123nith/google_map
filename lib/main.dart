import 'package:flutter/material.dart';
import 'package:google_map/google_map_styling.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: GoolgeMapStyling(),
    );
  }
}
