import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_map/utils/constant.dart';
import 'package:google_map/utils/googlemap_utils.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';

class DrawRouteTwoLocationSample extends StatefulWidget {
  @override
  _DrawRouteTwoLocationSample createState() => _DrawRouteTwoLocationSample();
}

class _DrawRouteTwoLocationSample extends State<DrawRouteTwoLocationSample> {

  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapUtils _googleMapsUtils = GoogleMapUtils();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
   LatLng latLng =GoogleMapUtils().locationDefault;
  LocationData currentLocation;
  @override
  void initState() {
    super.initState();
    _onAddMarkerButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
      GoogleMap(
       // polylines: polyLines,
        polylines: _polyLines,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 14.4746,
        ),
        onCameraMove:  onCameraMove,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          sendRequest();
        },
        label: Text('Destination'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: _googleMapsUtils.locationDefault,
        icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'from hear',
              snippet: "from here..."
          )
      ));
      _markers.add(Marker(
        markerId: MarkerId("2222"),
        position:_googleMapsUtils.locationTo,
       // icon: BitmapDescriptor.defaultMarker,
          icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
          title: 'to hear',
            snippet: "to here..."
        )
      ));
    });
  }


  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  void sendRequest() async {
    LatLng destination = _googleMapsUtils.locationTo;
    String route = await _googleMapsUtils.getRouteCoordinates(
        _googleMapsUtils.locationDefault, destination);
    createRoute(route);
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(latLng.toString()),
          width: 6,
          points: _googleMapsUtils.convertToLatLng(_googleMapsUtils.decodePoly(encondedPoly)),
          color: Colors.red));
    });
  }

}

