import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_map/utils/constant.dart';
import 'package:google_map/utils/marker.dart';
import 'package:google_map/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapSearchAutoComplete extends StatefulWidget {
  @override
  _MapSearchAutoCompleteState createState() => _MapSearchAutoCompleteState();
}

class _MapSearchAutoCompleteState extends State<MapSearchAutoComplete> {
  GoogleMapController mapController;
  LatLng locationDefault = Utils().locationDefault;
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
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: MarkerUtils().cameraPosition(locationDefault),
          ),
          Container(
            color: Colors.blue,
              child: GestureDetector(
                onTap: ()async {
                  Prediction p = await PlacesAutocomplete.show(
                    context: context, apiKey: Constant.API_KEY,
                      language: "en",
                      components: [Component(Component.country, "pk")]);
                  _getLatLng(p);
                },
                child: Text('Find address'),
              )
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
  initPrediction()async{
    Prediction prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constant.API_KEY,
        mode: Mode.fullscreen, // Mode.overlay
        language: "vi",
        components: [Component(Component.country, "vi")]);
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
  }
}
