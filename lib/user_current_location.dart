// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  // String address = '' ;
  final Completer<GoogleMapController> _controller = Completer();

  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'Title of marker ')),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );

  // List<Marker> list = const [
  //   Marker(
  //       markerId: MarkerId('1'),
  //       position: LatLng(33.6844, 73.0479),
  //       infoWindow: InfoWindow(
  //           title: 'some Info '
  //       )
  //   ),

  // ];

  @override
  void initState() {
    super.initState();
    _getUserCurrentLocation();
  }

  // loadData() {
  //   _getUserCurrentLocation().then((value) async {
  //     _markers.add(Marker(
  //         markerId: const MarkerId('SomeId'),
  //         position: LatLng(value.latitude, value.longitude),
  //         infoWindow: InfoWindow(title: address)));

  //     final GoogleMapController controller = await _controller.future;
  //     CameraPosition _kGooglePlex = CameraPosition(
  //       target: LatLng(value.latitude, value.longitude),
  //       zoom: 14,
  //     );
  //     controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.deepOrange,
      //   title: const Text('Flutter Google Map'),
      // ),
      // body: SafeArea(
      //   child: Stack(
      //  alignment: Alignment.bottomCenter,
      //  children: [
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        // mapType: MapType.normal,
        //  myLocationButtonEnabled: true,
        //  myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());
            _markers.add(
              Marker(
                markerId: const MarkerId('SomeId'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: "My Current Location"),
              ),
            );
            CameraPosition cameraPosition = CameraPosition(
                zoom: 14, target: LatLng(value.latitude, value.longitude));
            final GoogleMapController controller = await _controller.future;

            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.my_location_outlined),
      ),
      // Container(
      //   height: MediaQuery.of(context).size.height * .2,
      //   decoration: BoxDecoration(
      //       color: Colors.white, borderRadius: BorderRadius.circular(40)),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       InkWell(
      //         onTap: () {
      //           _getUserCurrentLocation().then((value) async {
      //             _markers.add(Marker(
      //                 markerId: const MarkerId('SomeId'),
      //                 position: LatLng(value.latitude, value.longitude),
      //                 infoWindow: InfoWindow(title: address)));
      //             final GoogleMapController controller =
      //                 await _controller.future;

      //             CameraPosition _kGooglePlex = CameraPosition(
      //               target: LatLng(value.latitude, value.longitude),
      //               zoom: 14,
      //             );
      //             controller.animateCamera(
      //                 CameraUpdate.newCameraPosition(_kGooglePlex));

      //             List<Placemark> placemarks = await placemarkFromCoordinates(
      //                 value.latitude, value.longitude);

      //             final add = placemarks.first;
      //             address = add.locality.toString() +
      //                 " " +
      //                 add.administrativeArea.toString() +
      //                 " " +
      //                 add.subAdministrativeArea.toString() +
      //                 " " +
      //                 add.country.toString();

      //             setState(() {});
      //           });
      //         },
      //         child: Padding(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //           child: Container(
      //             height: 40,
      //             decoration: BoxDecoration(
      //                 color: Colors.deepOrange,
      //                 borderRadius: BorderRadius.circular(8)),
      //             child: const Center(
      //                 child: Text(
      //               'Current Location',
      //               style: TextStyle(color: Colors.white),
      //             )),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 20),
      //         child: Text(address),
      //       )
      //     ],
      //   ),
      // )
      //   ],
      // ),
      // ),
    );
  }
}
