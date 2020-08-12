import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_map/utils/googlemap_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddListMarkerCustomIcon extends StatefulWidget {
  @override
  _AddListMarkerCustomIconState createState() => _AddListMarkerCustomIconState();
}

class _AddListMarkerCustomIconState extends State<AddListMarkerCustomIcon> {
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
  _addListMarker()async{
    LatLng location1 =  LatLng(10.7485542, 106.703325);
    LatLng location2 =  LatLng(10.7478945, 106.7038454);
    LatLng location3 =  LatLng(10.7497918, 106.7029972);
    LatLng location4 =  LatLng(10.7476224, 106.702676);

    // Uint8List imageData = await Utils().getMarker(context);// todo way 1
    //Uint8List _icon = await MarkerUtils().markerIcon(170);// todo way 2
    Uint8List icon1 = await GoogleMapUtils().markerIconPath(GoogleMapUtils().listIcon[2],90);// todo way 3
    Uint8List _icon2 = await GoogleMapUtils().markerIconPath(GoogleMapUtils().listIcon[3],90);// todo way 3
    Uint8List _icon3 = await GoogleMapUtils().markerIconPath(GoogleMapUtils().listIcon[4],90);// todo way 3
    setState(() {
      markers.addAll([
        Marker(
            icon: BitmapDescriptor.fromBytes(icon1),
            markerId: MarkerId('value'),
            position: location1,
          infoWindow: InfoWindow(
            title: 'the marker 1',
            // onTap: (){}// todo
          ),
        ),
        Marker(
            icon: BitmapDescriptor.fromBytes(_icon2),
            markerId: MarkerId('value2'),
            position: location2,
          infoWindow: InfoWindow(
          title: 'the marker 2',
          // onTap: (){}// todo
        ),),
        Marker(
            icon: BitmapDescriptor.fromBytes(_icon2),
            markerId: MarkerId('value3'),
            position: location3,
          infoWindow: InfoWindow(
            title: 'the marker 3',
            // onTap: (){}// todo
          ),),
        Marker(
            icon: BitmapDescriptor.fromBytes(_icon3),
            markerId: MarkerId('value4'),
            position: location4,
          infoWindow: InfoWindow(
            title: 'the marker 4',
            // onTap: (){}// todo
          ),),

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
