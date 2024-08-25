// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GooglePlaceApi extends StatefulWidget {
  const GooglePlaceApi({super.key});

  @override
  State<GooglePlaceApi> createState() => _GooglePlaceApiState();
}

class _GooglePlaceApiState extends State<GooglePlaceApi> {
  final TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  final String _sessionToken = "122344";

  List<dynamic> _placesList = [];
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDitS4XxxE8WGL8GwMt62vt7C5HuNAYj_0";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Google Search Place Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'Search places with name'),
            ),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  List<Location> locations = await locationFromAddress(
                      _placesList[index]['description']);
                },
                //     title: Text(_placesList[index]['description']),
              );
            }))
          ],
        ),
      ),
    );
  }
}
