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
  _SearchAddressAndDrawRouteState createState() =>
      _SearchAddressAndDrawRouteState();
}

class _SearchAddressAndDrawRouteState extends State<SearchAddressAndDrawRoute> {
  GoogleMapController mapController;
  LatLng locationDefault = GoogleMapUtils().locationDefault;
  GoogleMapUtils _googleMapsUtils = GoogleMapUtils();

  final Set<Polyline> _polyLines = {};
  TextEditingController sourceController = TextEditingController();
  TextEditingController destController = TextEditingController();
  Marker markerStart;
  Marker markerTo;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
//    _markers.add(markerStart);
//    _markers.add(markerTo);
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          polylines: _polyLines,
          markers: _markers != null ? Set<Marker>.from(_markers) : null,
          // myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          compassEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition:
              GoogleMapUtils().cameraPosition(locationDefault),
        ),
        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Material(
            child: Container(
            //  height: 100.0,
              width: double.infinity,
              decoration: getBoxShadow(),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: sourceController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.black,
                    decoration: getInoutDecoration(
                      "From Location?",
                      Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                    ),
                    onTap: () async {
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: Constant.API_KEY,
                          language: "vi",
                          mode: Mode.overlay,
                          // Mode.overlay or  Mode.fullscreen
                          components: [Component(Component.country, "vn")]);
                      _getLatLng(p, sourceController, true);
                    },
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  TextField(
                    controller: destController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.go,
                    onTap: () async {
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: Constant.API_KEY,
                          language: "vi",
                          mode: Mode.overlay,
                          // Mode.overlay or  Mode.fullscreen
                          components: [Component(Component.country, "vn")]);
                      _getLatLng(p, destController, false);
                    },
                    onSubmitted: (value) {},
                    decoration: getInoutDecoration(
                        "To locaation?",
                        Icon(
                          Icons.local_taxi,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Show Route'.toUpperCase(),  style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),),

                    ),
                    onPressed: (sourceController.text!=''&&destController.text!='')?(){
                      sendRequest();
                    }:null,color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  void sendRequest() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(markerStart.position!=null&&markerTo.position!=null){
      String route = await _googleMapsUtils.getRouteCoordinates(
          markerStart.position, markerTo.position);
      createRoute(route);
    }else{
      setState(() {
        sourceController.text='';
        destController.text='';
      });
    }

  }
  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(markerStart.position.toString()),
          width: 6,
          points: _googleMapsUtils.convertToLatLng(_googleMapsUtils.decodePoly(encondedPoly)),
          color: Colors.red));
    });
  }

  getBoxShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 5.0),
              blurRadius: 10,
              spreadRadius: 3)
        ]);
  }

  getInoutDecoration(hint, icon) {
    return InputDecoration(
      icon: Container(
        margin: EdgeInsets.only(left: 20, top: 5),
        width: 10,
        height: 10,
        child: icon,
      ),
      hintText: hint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    );
  }

  void _getLatLng(Prediction prediction,
      TextEditingController textEditingController, bool source) async {
    GoogleMapsPlaces _places =
        new GoogleMapsPlaces(apiKey: Constant.API_KEY); //Same API_KEY as above
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;
    print("latitude $latitude");
    print("longitude $longitude");
    print("address $address");

    setState(() {
      textEditingController.text = address;
      if (source) {
        _markers.remove(markerStart);
        markerStart = Marker(
            markerId: MarkerId("111"),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
            infoWindow: InfoWindow(title: address));
        _markers.add(markerStart);
      } else {
        _markers.remove(markerTo);
        markerTo = Marker(
            markerId: MarkerId("22"),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: address));
        _markers.add(markerTo);
      }
      GoogleMapUtils()
          .cameraPositionAnimation(mapController, LatLng(latitude, longitude));
    });
  }
}
