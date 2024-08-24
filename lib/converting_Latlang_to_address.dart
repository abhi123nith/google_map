// ignore_for_file: use_key_in_widget_constructors,, file_names, library_private_types_in_public_api
// library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

class ConvertingLatlangToAddress extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ConvertingLatlangToAddressState createState() =>
      _ConvertingLatlangToAddressState();
}

class _ConvertingLatlangToAddressState
    extends State<ConvertingLatlangToAddress> {
  String stAddress = '';
  Geocoder geocoder = Geocoder();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          GestureDetector(
            onTap: () async {
              try {
                final coordinates =
                    Coordinates(37.42796133580664, -122.885749655962);
                var addresses = await Geocoder.local
                    .findAddressesFromCoordinates(coordinates);
                var first = addresses.first;
                setState(() {
                  stAddress = "${first.featureName}, ${first.addressLine}";
                });
              } catch (e) {
                print(e);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Center(
                  child: Text("Convert"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
