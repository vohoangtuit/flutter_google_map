import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map/utils/googlemap_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddListMarkerDefault extends StatefulWidget {
  @override
  _AddListMarkerDefaultState createState() => _AddListMarkerDefaultState();
}

class _AddListMarkerDefaultState extends State<AddListMarkerDefault> {
  Set<Marker> markers = Set();
  LatLng locationDefault = GoogleMapUtils().locationDefault;
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('List Marker'),),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        markers: markers,

        initialCameraPosition: GoogleMapUtils().cameraPosition(locationDefault),
        //initialCameraPosition: MarkerUtils().cameraPositionAnimation(mapController,locationDefault),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      _addListMarker();
    });

  }
  _addListMarker(){
    LatLng location1 =  LatLng(10.7485542, 106.703325);
    LatLng location2 =  LatLng(10.7478945, 106.7038454);
    LatLng location3 =  LatLng(10.7497918, 106.7029972);
    LatLng location4 =  LatLng(10.7476224, 106.702676);
    setState(() {
      markers.addAll([
        Marker(
            markerId: MarkerId('value'),
            position: location1),
        Marker(
            markerId: MarkerId('value2'),
            position: location2),
        Marker(
            markerId: MarkerId('value3'),
            position: location3),
        Marker(
            markerId: MarkerId('value4'),
            position: location4),
      ]);

    }

    );
    if(mapController!=null){
      print("1111111111111111111111111");
      //MarkerUtils().cameraPositionAnimation(mapController,location1);
      GoogleMapUtils().cameraPositionAnimation(mapController,location1);
    }else{
      locationDefault = location1;//
      print("22222222222222222");
    }
  }
}
