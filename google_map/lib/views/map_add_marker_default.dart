import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapAddDefault extends StatefulWidget {
  @override
  _MapAddDefaultState createState() => _MapAddDefaultState();
}

class _MapAddDefaultState extends State<MapAddDefault> {
  Marker marker;
  GoogleMapController mapController;
  Location _locationTracker = Location();

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(10.8111281, 106.6945036),
    zoom: 17.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Add Default'),),
      body: installMap(),
    );
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      getCurrentLocation();
    });

  }
  GoogleMap installMap(){
    return GoogleMap(
      myLocationEnabled: true,
      compassEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: initialLocation,
      markers: Set.of((marker != null) ? [marker] : []),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
    );
  }

  void getCurrentLocation() async {
    try {
     // Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();
      if(location!=null){
        updateMarket(location);
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
        print("Permission Denied -----------------------------");
      }
    }
  }
  void updateMarket(LocationData location){
    print("updateMarket  -----------------------------");
    LatLng latlng = LatLng(location.latitude, location.longitude);
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(// move camera
          bearing: 192.8334901395799,
          target: LatLng(latlng.latitude, latlng.longitude),
          tilt: 0,
          zoom: 18.00)));
    }
   setState(() {
      marker = Marker(
          markerId: MarkerId('MarkerId'),
          position: latlng,
          infoWindow: InfoWindow(
              title: 'The title of the marker',
           // onTap: (){}// todo
          )
          ,
        icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        );
    });
  }
  @override
  void dispose() {

    super.dispose();
  }
}
