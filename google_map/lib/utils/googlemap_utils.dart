import 'dart:convert';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constant.dart';
class GoogleMapUtils{
  LatLng locationDefault = LatLng(10.7498708, 106.7041076);
  LatLng locationTo = LatLng(10.7438811, 106.6952904);
  var listIcon =[
    'assets/icons/icon_marker.png',
    'assets/icons/car_icon.png',
    'assets/icons/ic_marker_default.png',
    'assets/icons/ic_marker_drink.png',
    'assets/icons/ic_marker_food.png',
  ];

  CameraPosition cameraPosition(LatLng location){
    return CameraPosition(
        zoom: 16,
        bearing: 30,
        target: location
    );
  }
  CameraPosition cameraPositionAnimation(GoogleMapController mapController,LatLng location){
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            new CameraPosition(
       // bearing: 192.8334901395799,// todo: xoay map
        target: location,
        tilt: 0,
        zoom: 16)));
  }
  CameraPosition moveCameraAnimationWithZoom(GoogleMapController mapController,LatLng location, double zoom){
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            new CameraPosition(
               // bearing: 192.8334901395799,// todo: xoay map
                target: location,
                tilt: 0,
                zoom: zoom)));
  }
  Future<Uint8List> getMarker(BuildContext context) async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/ic_marker_drink.png");
    // ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/ic_marker_food.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> markerIcon(int size) async{

    return await getBytesFromAsset(listIcon[2], size);
  }
  Future<Uint8List> markerIconPath(String path,int size) async{

    return await getBytesFromAsset(path, size);
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    // import 'dart:ui' as ui;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${Constant.API_KEY}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    print("Predictions "+values.toString());
    return values["routes"][0]["overview_polyline"]["points"];
  }

  List decodePoly(String poly) {
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

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

}