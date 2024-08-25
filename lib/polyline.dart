import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  _PolylineScreenState createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> latLng = [
    const LatLng(9.000471, -79.495544),
    const LatLng(8.999406, -79.495831),
    const LatLng(8.998838, -79.494680),
    const LatLng(8.997630, -79.493314),
    const LatLng(8.995286, -79.495831),
    const LatLng(8.994078, -79.496335),
    const LatLng(8.992941, -79.495615),
    const LatLng(8.990029, -79.497701),
    const LatLng(8.985198, -79.502664),
    const LatLng(8.981359, -79.506608),
    const LatLng(8.969308, -79.514766),
  ];
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  // String googleAPiKey = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < latLng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latLng[i],
          infoWindow: const InfoWindow(
            title: 'Really cool place',
            snippet: '5 star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
      _polylines.add(Polyline(
          polylineId: const PolylineId('1'),
          points: latLng,
          color: Colors.orange));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PolyLine'),
        ),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
              target: LatLng(9.000471, -79.495544), zoom: 15),
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polylines: _polylines,
          markers: _markers,
        ));
  }

  // void _onMapCreated(GoogleMapController controller) async {
  //   mapController = controller;
  // }

  // _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
  //   MarkerId markerId = MarkerId(id);
  //   Marker marker =
  //       Marker(markerId: markerId, icon: descriptor, position: position);
  //   markers[markerId] = marker;
  // }

  // _addPolyLine() {
  //   PolylineId id = const PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: Colors.red, points: polylineCoordinates);
  //   polylines[id] = polyline;
  //   setState(() {});
  // }

  // _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPiKey,
  //       PointLatLng(_originLatitude, _originLongitude),
  //       PointLatLng(_destLatitude, _destLongitude),
  //       travelMode: TravelMode.driving,
  //       wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }
  //   _addPolyLine();
  // }
}
