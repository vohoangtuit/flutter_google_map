import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapWithMarkerLocation extends StatefulWidget {
  @override
  _MapWithMarkerLocationState createState() => _MapWithMarkerLocationState();
}

class _MapWithMarkerLocationState extends State<MapWithMarkerLocation> {
  Marker marker;
  GoogleMapController mapController;
  Location _locationTracker = Location();
  StreamSubscription _locationSubscription;
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(10.8111281, 106.6945036),
    zoom: 17.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map With Marker Location onChange'),),
      body: installMap(),
    );
  }
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
      var location = await _locationTracker.getLocation();

      updateMarket(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (mapController != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(// move camera
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00)));
          updateMarket(newLocalData);// add marker
        }
      });

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
    setState(() {
      marker = Marker(
          markerId: MarkerId('MarkerId'),
          position: latlng,
          infoWindow: InfoWindow(
              title: 'The title of the marker'
          )
      );
    });
  }
  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
}
