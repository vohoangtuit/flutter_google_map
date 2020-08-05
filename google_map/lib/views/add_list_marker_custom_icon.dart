import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_map/utils/marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddListMarkerCustomIcon extends StatefulWidget {
  @override
  _AddListMarkerCustomIconState createState() => _AddListMarkerCustomIconState();
}

class _AddListMarkerCustomIconState extends State<AddListMarkerCustomIcon> {
  Set<Marker> markers = Set();
  LatLng locationDefault = LatLng(10.8111281, 106.6945036);
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

        initialCameraPosition: MarkerUtils().cameraPosition(locationDefault),
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
  _addListMarker()async{
    LatLng location1 =  LatLng(10.7485542, 106.703325);
    LatLng location2 =  LatLng(10.7478945, 106.7038454);
    LatLng location3 =  LatLng(10.7497918, 106.7029972);
    LatLng location4 =  LatLng(10.7476224, 106.702676);

    // Uint8List imageData = await Utils().getMarker(context);// todo way 1
    //Uint8List _icon = await MarkerUtils().markerIcon(170);// todo way 2
    Uint8List icon1 = await MarkerUtils().markerIconPath(MarkerUtils().listIcon[2],170);// todo way 3
    Uint8List _icon2 = await MarkerUtils().markerIconPath(MarkerUtils().listIcon[3],170);// todo way 3
    Uint8List _icon3 = await MarkerUtils().markerIconPath(MarkerUtils().listIcon[4],170);// todo way 3
    setState(() {
      markers.addAll([
        Marker(
            icon: BitmapDescriptor.fromBytes(icon1),
            markerId: MarkerId('value'),
            position: location1),
        Marker(
            icon: BitmapDescriptor.fromBytes(_icon2),
            markerId: MarkerId('value2'),
            position: location2),
        Marker(
            icon: BitmapDescriptor.fromBytes(_icon2),
            markerId: MarkerId('value3'),
            position: location3),
        Marker(
            icon: BitmapDescriptor.fromBytes(_icon3),
            markerId: MarkerId('value4'),
            position: location4),
      ]);

    }

    );
    if(mapController!=null){
      print("1111111111111111111111111");
      //MarkerUtils().cameraPositionAnimation(mapController,location1);
      MarkerUtils().cameraPositionAnimation(mapController,location1);
    }else{
      locationDefault = location1;//
      print("22222222222222222");
    }
  }
}
