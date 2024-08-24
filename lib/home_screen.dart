import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGoogleplex =
      CameraPosition(target: LatLng(31.710384, 76.523626), zoom: 4.4746);

  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        //31.710384,76.523626
        markerId: MarkerId("1"),
        position: LatLng(31.710384, 76.523626),
        infoWindow: InfoWindow(title: "NBH Hostel")),
    const Marker(
        //31.710300,76.526524
        markerId: MarkerId("2"),
        position: LatLng(31.710300, 76.526524),
        infoWindow: InfoWindow(title: "KBH")),
    const Marker(
        //31.710384,76.523626
        markerId: MarkerId("3"),
        position: LatLng(31.706000, 76.524385),
        infoWindow: InfoWindow(title: "NITH Ground")),
    const Marker(
        //31.710300,76.526524
        markerId: MarkerId("4"),
        position: LatLng(31.688917, 76.515783),
        infoWindow: InfoWindow(title: "Indian Oil")),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogleplex,
          markers: Set<Marker>.of(_marker),
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(target: LatLng(31.688917, 76.515783))));
          setState(() {});
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
