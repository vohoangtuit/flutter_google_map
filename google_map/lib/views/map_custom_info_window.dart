import 'package:flutter/material.dart';
import 'package:google_map/utils/marker.dart';
import 'package:google_map/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCustomInfoWindown extends StatefulWidget {

  @override
  _MapCustomInfoWindownState createState() => _MapCustomInfoWindownState();
}

class _MapCustomInfoWindownState extends State<MapCustomInfoWindown> {
  Set<Marker> markers = Set();
  LatLng locationDefault = Utils().locationDefault;
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom InfoWindown'),),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: MarkerUtils().cameraPosition(locationDefault),
        //initialCameraPosition: MarkerUtils().cameraPositionAnimation(mapController,locationDefault),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      getData();
    });
  }
  getData(){

  }
}
