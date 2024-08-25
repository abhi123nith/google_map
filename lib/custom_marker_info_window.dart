import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = <LatLng>[
    const LatLng(33.6941, 72.9734),
    const LatLng(33.7008, 72.9682),
    const LatLng(33.6992, 72.9744),
    const LatLng(33.6939, 72.9771),
    const LatLng(33.6910, 72.9807),
    const LatLng(33.7036, 72.9785)
  ];

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  void loadMarkers() {
    for (int i = 0; i < _latLang.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLang[i],
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                width: 200,
                height: i.isOdd ? 200 : 100, // Adjust height conditionally
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Show image and product if index is odd
                    if (i.isOdd)
                      Container(
                        height: 120,
                        width: 180,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://millies.ie/cdn/shop/files/IMAGESkincareVitalCHydratingEyeRecoveryGel.jpg?v=1682674342&width={width}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    // Add some spacing if the image is shown
                    if (i.isOdd) const SizedBox(height: 10),
                    // Show product details (always shown)
                    const Text(
                      "Hydrating Eye Gel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (i.isOdd) const SizedBox(height: 5),
                    const Text(
                      "It is a very good product for skin care ewfngdjkn gndjbnS JGNAJN ADGNFAJA",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      overflow:
                          TextOverflow.ellipsis, // Add this to handle overflow
                      maxLines: 2, // Limit the text to 2 lines
                    ),
                  ],
                ),
              ),
              _latLang[i],
            );
          },
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Info Window'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(33.6941, 72.9734),
              zoom: 14,
            ),
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 200,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
