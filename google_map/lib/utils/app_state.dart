import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'locationpath.dart';
class AppState extends ChangeNotifier{
  static LatLng _initialPosition;
  static LatLng _lastPosition;
  GoogleMapController _mapController;
  //Set_markers={};
  Set<Marker> _markers = Set();
  Set  _polyLines={};
  bool _isLoading=false;

  //To Handle Text fileds data
  TextEditingController sourceController=TextEditingController();
  TextEditingController destController=TextEditingController();

  //To Get the Marker Psotions
  LatLng get initialPosition => _initialPosition;
  LatLng get lastposition => _lastPosition;

  //To check the Route Fetching stage
  bool get isLoading => _isLoading;

  GoogleMapController get mapController => _mapController;

  //TO Load Marjers on to Map
  Set get markers => _markers;

  //To Load route on Map
  Set get polyLines => _polyLines;

  Locationpath _locationPath = Locationpath();
  AppState()
  {
    _getUserLocation();
  }
  //  ON CREATE, Will set the MapController after loading the Map
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  // Handle the CameraMove Position
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

// Fetch the User Current location
  void _getUserLocation() async {

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);

    sourceController.text = placemark[0].name;
    _markers.add(Marker(markerId: MarkerId(position.toString()),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),position: LatLng(position.latitude, position.longitude)));
    notifyListeners();
  }

  // To Request Route path to Goolge Webservice
  void sendRequest(String intendedLocation) async {
    _isLoading=true;
    List placemark =
    await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation);
    String route = await _locationPath.getRouteCoordinates(
        _initialPosition, destination);
    createRoute(route);
    notifyListeners();
  }

  // Add marker to markers set and update Map on Marker
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "Destination"),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }
// ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.deepPurple));
    _isLoading=false;
    notifyListeners();
  }

  List _convertToLatLng(List points) {
    List result = [];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }
  // DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;

    do {
      var shift = 0;
      int result = 0;


      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);

      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }
}