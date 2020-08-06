import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MarkerUtils{
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
}