import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_map/utils/constant.dart';
import 'package:google_map/utils/googlemap_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapSearchAutoComplete extends StatefulWidget {
  @override
  _MapSearchAutoCompleteState createState() => _MapSearchAutoCompleteState();
}

class _MapSearchAutoCompleteState extends State<MapSearchAutoComplete> {
  GoogleMapController mapController;
  LatLng locationDefault = GoogleMapUtils().locationDefault;
  final Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Auto Complete'),),
      body: Stack(
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
          Container(
           // alignment: Alignment.topCenter,
            height: 40,
              child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: Colors.deepOrange,
                     child: Text('Find Address',style: TextStyle(color: Colors.white, fontSize: 16),),
                    onPressed: ()async{
                      Prediction p = await PlacesAutocomplete.show(
                          context: context, apiKey: Constant.API_KEY,
                          language: "vi",
                          mode: Mode.overlay, // Mode.overlay or  Mode.fullscreen
                          components: [Component(Component.country, "vn")]);
                      _getLatLng(p);
                    },
                  ))
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _getLatLng(Prediction prediction) async {
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
        _markers.clear();

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
