import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_map/model/restaurant.dart';
import 'package:google_map/utils/googlemap_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListRestaurantsShowMap extends StatefulWidget {

  @override
  _ListRestaurantsShowMapState createState() => _ListRestaurantsShowMapState();
}

class _ListRestaurantsShowMapState extends State<ListRestaurantsShowMap> {
  Set<Marker> markers = Set();
  LatLng locationDefault = GoogleMapUtils().locationDefault;
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurants'),),
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
      getData();
    });

  }
  getData() async {
    List<Restaurant> restaurants = new Restaurant().initData();
    Set<Marker> marker = Set();
    Uint8List _icon = await GoogleMapUtils().markerIconPath(GoogleMapUtils().listIcon[4],90);
    LatLng latLngMoveCamera;
    if(restaurants!=null){
      latLngMoveCamera =LatLng(restaurants[0].latitude,restaurants[0].longitude);
      for( var restaurant in restaurants){
        if(restaurant.latitude!=null&&restaurant.longitude!=null){
          marker.add(Marker(
            icon: BitmapDescriptor.fromBytes(_icon),
              markerId: MarkerId(restaurant.id),
              position: LatLng(restaurant.latitude,restaurant.longitude),
             infoWindow: InfoWindow(
              title: restaurant.name
            ),
          ));
        }

      }
      setState(() {
        markers =marker;
        GoogleMapUtils().moveCameraAnimationWithZoom(mapController,latLngMoveCamera,14);
      });
    }
  }
}
