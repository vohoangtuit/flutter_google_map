import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map/utils/marker.dart';
import 'package:google_map/utils/utils.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomIconMarker extends StatefulWidget {
  @override
  _CustomIconMarkerState createState() => _CustomIconMarkerState();
}

class _CustomIconMarkerState extends State<CustomIconMarker> {
  BitmapDescriptor pinLocationIcon;
  Uint8List markerIcon;
  Marker marker;
  GoogleMapController _controller;
  LatLng locationDefault = LatLng(10.8111281, 106.6945036);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Icon'),),
      body: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: MarkerUtils().cameraPosition(locationDefault),
        markers: Set.of((marker != null) ? [marker] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    addMarker();
  }
//  CameraPosition cameraPosition(LatLng location){
//    return CameraPosition(
//        zoom: 16,
//        bearing: 30,
//        target: location
//    );
//  }
   addMarker() async {
    // Uint8List imageData = await Utils().getMarker(context);// todo way 1
     Uint8List imageData = await MarkerUtils().markerIcon(170);// todo way 2
    // Uint8List _icon = await MarkerUtils().markerIconPath(MarkerUtils().listIcon[4],170);// todo way 3
    setState(() {
      marker = Marker(
        markerId: MarkerId('<MARKER_ID>'),
        position: locationDefault,
          infoWindow: InfoWindow(
            title: 'The title of the marker',
            // onTap: (){}// todo
          ),
          icon: BitmapDescriptor.fromBytes(imageData),
      );
    });
  }

}
