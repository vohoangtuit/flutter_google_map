import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_map/utils/marker.dart';
import 'package:google_map/utils/utils.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawRouteTwoLocationSample extends StatefulWidget {
// https://developers.google.com/maps/documentation/directions/get-api-key
// https://github.com/Dammyololade/flutter_polyline_points
  @override
  _DrawRouteTwoLocationSampleState createState() => _DrawRouteTwoLocationSampleState();
}

class _DrawRouteTwoLocationSampleState extends State<DrawRouteTwoLocationSample> {
  Set<Marker> markers = Set();
  LatLng locationDefault = Utils().locationDefault;
  LatLng locationTo = Utils().locationTo;
  final Set<Polyline>_polyline={};
  List<LatLng> routeCoords =List<LatLng>();
  GoogleMapController mapController;
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyCrdsRSWgms4aN4mcccQ2uzS2tUYqFv9Nk");// in manifest
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Draw route Two Location Sample'),),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _polyline.add(Polyline(
              polylineId: PolylineId('route1'),
              visible: true,
              points: routeCoords,
              width: 4,
              color: Colors.blue,
              startCap: Cap.roundCap,
              endCap: Cap.buttCap));
        },
        polylines: _polyline,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: MarkerUtils().cameraPosition(locationDefault),

      ),
    );
  }
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      getData();
      //getaddressPoints();
    });
   // _drawRoute();
  }
  getData() async{
    Uint8List _icon = await MarkerUtils().markerIconPath(MarkerUtils().listIcon[4],90);
    Set<Marker> marker = Set();
    marker.add(Marker(
      icon: BitmapDescriptor.fromBytes(_icon),
      position: locationDefault,
      markerId: MarkerId('1'),
      infoWindow: InfoWindow(
          title: 'From'
      ),
    ));
    marker.add(Marker(
      icon: BitmapDescriptor.fromBytes(_icon),
      position: locationTo,
      markerId: MarkerId('2'),
      infoWindow: InfoWindow(
          title: 'To'
      ),
    ));

    MarkerUtils().moveCameraAnimationWithZoom(mapController, locationDefault, 12);
    setState(() {
      markers =marker;
      getsomePoints();
    });

  }
  getaddressPoints() async {
    routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: '95 Lê Văn Lương, Tân Kiểng, Quận 7, Thành phố Hồ Chí Minh',
        destination: 'Hưng điền B, Tân Hưng, Long An',
        mode: RouteMode.driving);
  }
  getsomePoints() async {
    routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: locationDefault,
        destination: locationTo,
        mode: RouteMode.driving);
  }
  _drawRoute() async{
    setState(() async{
      routeCoords= await googleMapPolyline.getCoordinatesWithLocation(
          origin: locationDefault,
          destination: locationTo,
          mode:  RouteMode.driving);
    });

  }
}
