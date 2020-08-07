import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_map/model/restaurant.dart';
import 'package:google_map/utils/marker.dart';
import 'package:google_map/utils/utils.dart';
import 'package:google_map/views/detail_restaurant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapShowDetailPopup extends StatefulWidget {
  @override
  _MapShowDetailPopupState createState() => _MapShowDetailPopupState();
}

class _MapShowDetailPopupState extends State<MapShowDetailPopup> {
  Set<Marker> markers = Set();
  LatLng locationDefault = Utils().locationDefault;
  GoogleMapController mapController;
  Restaurant restaurantDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map show detail popup'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: (locationDefault){
              _closeDetail();
            },
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            markers: markers,
            initialCameraPosition:
                MarkerUtils().cameraPosition(locationDefault),
            //initialCameraPosition: MarkerUtils().cameraPositionAnimation(mapController,locationDefault),
          ),
          detailRestaurant(restaurantDetail),
        ],
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
    Uint8List _icon =
        await MarkerUtils().markerIconPath(MarkerUtils().listIcon[4], 90);
    LatLng latLngMoveCamera;
    if (restaurants != null) {
      latLngMoveCamera =
          LatLng(restaurants[0].latitude, restaurants[0].longitude);
      setState(() {
        restaurantDetail = restaurants[0];
      });
      for (var restaurant in restaurants) {
        if (restaurant.latitude != null && restaurant.longitude != null) {
          marker.add(Marker(
            icon: BitmapDescriptor.fromBytes(_icon),
            onTap: (){// todo tap  marker
              setState(() {
                restaurantDetail = restaurant;
              });
            },
            markerId: MarkerId(restaurant.id),
            position: LatLng(restaurant.latitude, restaurant.longitude),
//            infoWindow: InfoWindow(// todo tap on title marker
//                title: restaurant.name,
//                onTap: () {
//                  setState(() {
//                    restaurantDetail = restaurant;
//                  });
//                }),
          ));
        }
      }
      setState(() {
        markers = marker;
        MarkerUtils()
            .moveCameraAnimationWithZoom(mapController, latLngMoveCamera, 14);
      });
    }
  }
  _closeDetail(){
    setState(() {
      restaurantDetail =null;
    });
  }

  Widget detailRestaurant(Restaurant restaurant) {
    if (restaurant != null) {
      print("restaurant " + restaurant.name);
    }
    return restaurant != null
        ? Align(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailResTauRant(restaurant)));
  },
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                width: 280,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        restaurant.image,
                        width: 90,
                        height: 170,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  restaurant.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                   style: TextStyle(color: Colors.deepOrange, fontSize: 16, fontWeight: FontWeight.bold),
                                  // softWrap: true,
                                ),


                                RatingBar(
                                  initialRating: restaurant.rating,
                                  minRating: 1,
                                  itemSize: 18,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                 // tapOnlyMode: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
//                                onRatingUpdate: (rating) {// todo: disable update
//                                  //print(rating);
//                                },
                                ),
                              ],
                            ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            alignment: FractionalOffset.bottomCenter,
          )
        : SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }
}
