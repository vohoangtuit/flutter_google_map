import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_map/utils/constant.dart';
import 'package:google_map/utils/googlemap_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class SearchAddressAndDrawRoute extends StatefulWidget {
  // todo: https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/
  // todo: https://github.com/sbis04/flutter_maps
  @override
  _SearchAddressAndDrawRouteState createState() => _SearchAddressAndDrawRouteState();
}

class _SearchAddressAndDrawRouteState extends State<SearchAddressAndDrawRoute> {
  GoogleMapController mapController;
  LatLng locationDefault = GoogleMapUtils().locationDefault;
  final Set<Marker> _markers = {};
  TextEditingController sourceController = TextEditingController();
  TextEditingController destController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          markers: _markers,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: GoogleMapUtils().cameraPosition(locationDefault),
        ),
        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,

          child: Material(
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: getBoxShadow(),
              child: TextField(
                controller: sourceController,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                decoration:getInoutDecoration("pick up Location?",Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),),
                onTap: ()async{
                  Prediction p = await PlacesAutocomplete.show(
                      context: context, apiKey: Constant.API_KEY,
                      language: "vi",
                      mode: Mode.overlay, // Mode.overlay or  Mode.fullscreen
                      components: [Component(Component.country, "vn")]);
                  _getLatLng(p,sourceController,true);
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 105.0,
          right: 15.0,
          left: 15.0,
          child: Material(
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration:getBoxShadow(),
              child: TextField(
                controller: destController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.go,

                onTap: ()async{
                  Prediction p = await PlacesAutocomplete.show(
                      context: context, apiKey: Constant.API_KEY,
                      language: "vi",
                      mode: Mode.overlay, // Mode.overlay or  Mode.fullscreen
                      components: [Component(Component.country, "vn")]);
                  _getLatLng(p,destController,false);
                },
                onSubmitted: (value) {

                },
                decoration: getInoutDecoration("destination?",Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
  getBoxShadow()
  {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 5.0),
              blurRadius: 10,
              spreadRadius: 3)
        ]);

  }
  getInoutDecoration(hint,icon)
  {
    return InputDecoration(
      icon: Container(
        margin: EdgeInsets.only(left: 20, top: 5),
        width: 10,
        height: 10,
        child:icon ,
      ),
      hintText: hint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    );
  }

  void _getLatLng(Prediction prediction, TextEditingController textEditingController, bool source) async {
    GoogleMapsPlaces _places = new
    GoogleMapsPlaces(apiKey: Constant.API_KEY);  //Same API_KEY as above
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;
    print("latitude $latitude");
    print("longitude $longitude");
    print("address $address");

    setState(() {
      //_markers.clear();
      textEditingController.text =address;
      _markers.add(Marker(
          markerId: MarkerId("2222"),
          position:LatLng(latitude,longitude),
          // icon: BitmapDescriptor.defaultMarker,
          icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: address)
      ));
      GoogleMapUtils().cameraPositionAnimation(mapController,LatLng(latitude,longitude));
    });

  }
}
